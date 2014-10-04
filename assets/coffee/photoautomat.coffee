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
            flash      : ".Photoautomat__flash"
            red_button : ".Photoautomat__red-button"
        
        @CONFIG =
            default_size : [200, 160]
        
        @photoTaken = []
        @isReady   = no
        @retry     = 0

    bindUI: =>
        that = this
        # TODO: to be called later
        @askPermission()

    askPermission: =>
        # initialize webcam manager
        @sayCheese = new SayCheese(@ui.get(0), audio: false)
        @sayCheese.on("start", => @isReady = yes)
        @sayCheese.on("snapshot", @onSnapshotTaken)
        @sayCheese.start()

    takeSnapshot: (callback) =>
        # cancel the previous timeout
        clearTimeout(@restartLaterTimeout)
        # register the callback
        callback  = (->) unless canvas?
        @callback = callback
        # take the snapshot if ready, otherwise, try later
        if @isReady
            @ui.removeClass("hidden")
            # start the red light
            @uis.red_button
                .opacity(0)
                .show()
                .removeClass("hidden")
                .animate({opacity: 1}  , 1000)
                .animate({opacity: 0}  , 1000)
                .animate({opacity: 1}  , 1000)
                .animate({opacity: 0}  , 1000)
                .animate({opacity: 1}  , 1000)
                .animate({opacity: 0}  , 1000, "swing", =>
                    # start the flash
                    @uis.flash.removeClass("hidden")
                        .show()
                        .opacity(1)
                        .animate({opacity: 0.5}, 300)
                        .animate({opacity: 1}  , 300)
                        .animate({opacity: 0}  , 300, "swing")
                    @sayCheese.takeSnapshot(@CONFIG.default_size[0], @CONFIG.default_size[1])
                )
        else
            @retry += 1
            @restartLaterTimeout = setTimeout(@takeSnapshot, 300) unless @retry > 5

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
        # image = new Image()
        # image.src = canvas.toDataURL("image/png")
        # # @ui.find(".positif").append(image)
        # @ui.append(image)

# EOF
