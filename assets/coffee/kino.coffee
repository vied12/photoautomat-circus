# Encoding: utf-8
# Project : 
# -----------------------------------------------------------------------------
# Author : Edouard Richard                                  <edou4rd@gmail.com>
# -----------------------------------------------------------------------------
# License : GNU General Public License
# -----------------------------------------------------------------------------
# Creation : 04-Oct-2014
# Last mod : 04-Oct-2014
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

class Kino extends serious.Widget

    @CONFIG = 
        videos : [
            "https://vimeo.com/108045789"
            "https://vimeo.com/108038203"
            "https://vimeo.com/108038204"
        ]

    constructor: ->
        @UIS =
            screener : ".Kino__screener"
            iframe   : ".Kino__screener iframe"
            more     : ".Kino__more"
        @CONFIG = Kino.CONFIG
        @currentVideo = 0

    bindUI: () =>
        @navigation         = serious.Widget.ensureWidget(".Navigation")
        @photoautomatWidget = serious.Widget.ensureWidget(".Photoautomat")

    onArrive: (video_id) =>
        if video_id == undefined
            video_id = @currentVideo
        @startVideo(video_id)

    onLeave: =>
        @cancel = yes
        # stop the video
        try
            if @player
                @player.api("pause")
                @player.api("unload")
        catch e
            console.log e.message
        @player = null
        @uis.iframe.attr("src", "")

    startVideo: (video_id) =>
        # update currentVideo
        @currentVideo = video_id
        # set the video url into the iframe
        @uis.iframe.attr("src", "//player.vimeo.com/video/#{_.last(@CONFIG.videos[video_id].split("/"))}?api=1&amp;title=0&amp;byline=0&amp;portrait=0&amp;player_id=Kino_iframe_#{video_id}").attr("id", "Kino_iframe_#{video_id}")
        # get the video api
        @player = $f(@uis.iframe.get(0))
        @player.addEvent 'ready', =>
            # bind some events
            @player.addEvent('finish'      , @onFinish)
            # player.addEvent('pause'       , @onPause)
            # player.addEvent('playProgress', @onPlayProgress)
            # start the video
            @player.api("play")
        # bind modal on button click
        @uis.more.click =>
            modal = serious.Widget.ensureWidget("#Modal__Video#{@currentVideo}")
            modal.open()

    openModal: () =>


    onPlayProgress:(data, id) =>

    onFinish: =>
        # remove the video from the screen
        @uis.iframe.attr("src", "")
        # there is a next video
        if @currentVideo < @CONFIG.videos.length - 1
            # this will ask for next video at the end
            @startPhotoTransition()
        else
            @navigation.nextScreen()

    onPause: =>

    startPhotoTransition: =>
        @photoautomatWidget.takeSnapshot =>
            @startVideo(@currentVideo + 1)

# EOF
