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

class IntroKino extends serious.Widget

    constructor: ->
        @UIS =
            sound_cabine: "#Intro-kino__sound__cabine"
            sound_argent: "#Intro-kino__sound__argent"
    
    bindUI: =>
        @ko = yes
        @photoautomatWidget = serious.Widget.ensureWidget(".Photoautomat")
        @navigation         = serious.Widget.ensureWidget(".Navigation")
        @modal              = serious.Widget.ensureWidget("#Modal__intro-kino")
        @scope.next = =>
            @uis.sound_argent.get(0).play()
            setTimeout(=>
                @photoautomatWidget.takeSnapshot =>
                    @navigation.nextScreen()
            , 500)

    onArrive: =>
        $("body").removeClass("without-navigation")
        @photoautomatWidget.askPermission()
        @uis.sound_cabine.get(0).play()
        @modal.open()

    onLeave: =>
        @uis.sound_cabine.get(0).pause()
        @modal.close()

# EOF
