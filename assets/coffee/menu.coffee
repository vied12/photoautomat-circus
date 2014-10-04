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

class Menu extends serious.Widget

    constructor: ->
        @isOpen = yes

    bindUI: () =>
        @ko = yes
        # get the widget instances
        @navigation = serious.Widget.ensureWidget(".Navigation")
        # init the menu
        # @relayout()
        @close()
        # define scope available in the template
        @scope.toggle    = @toggle
        @scope.mute      = @mute
        @scope.see_movie = @seeMovie
        @scope.about     = @about
        # bind events
        # $(window).resize(@relayout)

    # relayout: =>
    #     @ui.height($(window).height())

    open: =>
        @ui.css
            top: 0
        $(".Menu__toggle").addClass("active")
        @isOpen = yes

    close: =>
        offscreen_offset =  - (@ui.height() + 300)
        @ui.css
            top: offscreen_offset
        $(".Menu__toggle").removeClass("active")
        @isOpen = no

    # -----------------------------------------------------------------------------
    #    ACTIONS
    # -----------------------------------------------------------------------------
    toggle: =>
        if @isOpen
            @close()
        else
            @open()

    seeMovie: (movie_id) =>
        @navigation.goToScreen("Kino", movie_id)
        @close()

    mute: =>
        console.log "mute ta yeule!"

    about: =>
        @close()

# EOF
