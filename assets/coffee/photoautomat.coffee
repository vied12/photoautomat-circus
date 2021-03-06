# Encoding: utf-8
# Project : 
# -----------------------------------------------------------------------------
# Author : Edouard Richard                                  <edou4rd@gmail.com>
# -----------------------------------------------------------------------------
# License : GNU General Public License
# -----------------------------------------------------------------------------
# Creation : 03-Oct-2014
# Last mod : 03-Oct-2014
# -----------------------------------------------------------------------------
# This file is part of Serious-Toolkit.
# 
#     Serious-Toolkit is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     Serious-Toolkit is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with Serious-Toolkit.  If not, see <http://www.gnu.org/licenses/>.

class Photoautomat extends serious.Widget

    constructor: ->
        @UIS    =
            flash       : ".Photoautomat__flash"
            mirrors_off : ".Photoautomat__mirror.off"
            mirrors_on  : ".Photoautomat__mirror.on"
            sound_flash : "#Photoautomat__sound__flash"
        @CONFIG =
            default_size : [80, 100]
        
        @photoTaken = []
        @isReady   = no

    bindUI: =>
        that = this
        @modal = serious.Widget.ensureWidget("#Modal__intro-kino")

    askPermission: =>
        # initialize webcam manager
        @sayCheese = new SayCheese(@ui.get(0), audio: false)
        @sayCheese.on("snapshot", @onSnapshotTaken)
        @sayCheese.on "start", =>
            @isReady = yes
            @modal.close()
        @sayCheese.start()

    takeSnapshot: (callback) =>
        # register the callback
        @callback = callback or (->)
        @ui.removeClass("hidden")
        # start the red light
        @uis.mirrors_on
            .opacity(0)
            .removeClass("hidden")
        @uis.mirrors_on
            .animate({opacity: 1}  , 1000)
            .animate({opacity: 0}  , 1000)
            .animate({opacity: 1}  , 1000)
            .animate({opacity: 0}  , 1000)
            .animate({opacity: 1}  , 1000)
            .animate {opacity: 0}  , 1000, null, =>
                # start the flash
                @uis.flash.removeClass("hidden")
                    .show()
                    .opacity(1)
                    .animate({opacity: 0.5}, 300, null, (=> @uis.sound_flash.get(0).play()))
                    .animate({opacity: 1}  , 300)
                    .animate {opacity: 0}  , 300, "swing", =>
                        @ui.addClass("hidden")
                if @isReady
                    @sayCheese.takeSnapshot(@CONFIG.default_size[0], @CONFIG.default_size[1])
                else
                    @callback()

    onSnapshotTaken: (canvas) =>
        # to b&w
        context    = canvas.getContext("2d")
        image_data = context.getImageData(0, 0, @CONFIG.default_size[0], @CONFIG.default_size[1])
        pix        = image_data.data
        i          = 0
        n          = pix.length
        while i < n
            grayscale  = pix[i] * .3 + pix[i + 1] * .59 + pix[i + 2] * .11
            pix[i]     = grayscale # red
            pix[i + 1] = grayscale # green
            pix[i + 2] = grayscale # blue
            i += 4
        # alpha
        context.putImageData image_data, 0, 0
        @photoTaken.push(canvas)
        @callback(canvas)
        @callback = null

    getPhoto: =>
        positif = $("<div>")
            .addClass("positif")
        if @photoTaken.length < 1
            for i in [1..4] by 1
                positif.append($("<div style='background-color:#C6C6C6; whidth:#{@CONFIG.default_size[0]}px; height:#{@CONFIG.default_size[1]}px;'>"))
        else
            for pic_canvas in @photoTaken
                img = new Image()
                img.src = pic_canvas.toDataURL("image/png")
                positif.append(img)
            if positif.find("> *").length < 4
                for i in [1..(4 - positif.find("> *").length)] by 1
                    positif.prepend($(img).clone())
        return positif

# EOF
