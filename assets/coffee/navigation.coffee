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

class Navigation extends serious.Widget

    constructor: ->
        @UIS =
            screens            : ".screen"
        @currentScreen = 0

    bindUI : =>
        # get the widget instance
        @kinoWidget = serious.Widget.ensureWidget(".Kino")
        # init screen
        @uis.screens.opacity(0).hide()
        @goToScreen(@currentScreen) # Loader
        # preload and go to next screen
        setTimeout(@nextScreen, 1000)
        # debug
        @ui.find(".next_screen_debugger")    .click(@nextScreen)
        @ui.find(".previous_screen_debugger").click(@previousScreen)

    goToScreen: (screen_id, params) =>
        # support selector by class name
        if typeof(screen_id) == "string"
            screen_ui = @uis.screens.filter(".#{screen_id}")
            screen_id = @uis.screens.index(screen_ui)
        else
            screen_ui = @uis.screens.eq(screen_id)
        console.log "Navigation::go to screen", screen_id, screen_ui.attr("class")
        @uis.screens.opacity(0).hide()
        screen_ui.show().opacity(1)
        # try to call a onArrive method if the screen is a widget
        if screen_ui[0]._widget? and screen_ui[0]._widget.onArrive?
            screen_ui[0]._widget.onArrive(params)
        # update the currentScreen
        @currentScreen = screen_id

    nextScreen: =>
        console.log "nextScreen"
        if @currentScreen < (@uis.screens.length - 1)
            @goToScreen(@currentScreen+1)

    previousScreen: =>
        if @currentScreen > 0
            @goToScreen(@currentScreen-1)

# EOF
