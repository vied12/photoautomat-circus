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

    startVideo: (video_id) =>
        console.log "KINO::startVideo", video_id
        @currentVideo = video_id
        @uis.iframe.attr("src", "//player.vimeo.com/video/#{_.last(@CONFIG.videos[video_id].split("/"))}?api=1")
        iframe = @ui.find("iframe")[0]
        player = $f(iframe)
        player.addEvent 'ready', =>
            # player.addEvent('pause'       , @onPause)
            # player.addEvent('finish'      , @onFinish)
            # player.addEvent('playProgress', @onPlayProgress)
            player.api("play")

    onPlayProgress:(data, id) =>
        console.log "KINO::onPlayProgress", data, id

    onFinish: =>
        console.log "KINO::onFinish"

    onPause: =>
        console.log "KINO::onPause"

# EOF
