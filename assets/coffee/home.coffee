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

class Home extends serious.Widget

    constructor: ->
        @UIS =
            iframe : "iframe"
        @cancel = no

    bindUI: =>
        @navigation = serious.Widget.ensureWidget(".Navigation")
        @player     = $f(@uis.iframe.get(0))
        @player.addEvent 'ready', =>
            @player.addEvent 'finish' , =>
                @navigation.nextScreen() unless @cancel

    onArrive: =>
        $("body").removeClass("without-navigation")
        @cancel = no
        # start the video
        @player.api("play")

    onLeave: =>
        @cancel = yes
        # stop the video
        @player.api("pause")
        @player.api("unload")

    # constructor: ->
    #   @UIS =
    #       drapes : ".drapes"

    # onArrive: =>
    #   $("body").removeClass("without-navigation")
    #   # replay the gif animation
    #   @uis.drapes.css("background-image", "url(static/images/drapes.gif?v=#{new Date().getTime()})")

# EOF
