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
            "http://vimeo.com/103544659"
            "http://vimeo.com/61473487"
        ]

    constructor: ->
        @UIS =
            screener : ".Kino__screener"
            iframe   : ".Kino__screener iframe"
        @CONFIG = Kino.CONFIG

    bindUI: () =>
        @navigation         = serious.Widget.ensureWidget(".Navigation")
        @photoautomatWidget = serious.Widget.ensureWidget(".Photoautomat")

    startVideo: (video_id) =>
        console.log "KINO::startVideo", video_id
        # update currentVideo
        @currentVideo = video_id
        # set the video url into the iframe
        @uis.iframe.attr("src", "//player.vimeo.com/video/#{_.last(@CONFIG.videos[video_id].split("/"))}?api=1&title=0&amp;byline=0&amp;portrait=0")
        # get the video api
        player = $f(@uis.iframe.get(0))
        player.addEvent 'ready', =>
            # bind some events
            player.addEvent('finish'      , @onFinish)
            # player.addEvent('pause'       , @onPause)
            # player.addEvent('playProgress', @onPlayProgress)
            # start the video
            player.api("play")

    onPlayProgress:(data, id) =>
        console.log "KINO::onPlayProgress", data, id

    onFinish: =>
        console.log "KINO::onFinish"
        # remove the video from the screen
        @uis.iframe.attr("src", "")
        # there is a next video
        if @currentVideo < @CONFIG.videos.length - 1
            # this will ask for next video at the end
            @startPhotoTransition()
        else
            @navigation.nextScreen()

    onPause: =>
        console.log "KINO::onPause"

    startPhotoTransition: =>
        @photoautomatWidget.takeSnapshot()

# EOF
