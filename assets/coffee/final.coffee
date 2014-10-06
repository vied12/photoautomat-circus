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

class Final extends serious.Widget

    constructor: ->
        @UIS = 
            receptacle : ".Final__receptacle"
            photo      : ".Final__receptacle__photo"
            final_photo: ".Final__photo"
            sandbox    : ".Final__sandbox"

    bindUI: =>
        @ko = yes
        @navigation = serious.Widget.ensureWidget(".Navigation")
        @photoautomatWidget = serious.Widget.ensureWidget(".Photoautomat")
        @scope.about = =>(@navigation.goToScreen("About"))

    onArrive: =>
        photo = @photoautomatWidget.getPhoto()
        @uis.photo
            .css("bottom":300)
            .html(photo)
        setTimeout(=>
            @uis.photo.css("bottom":30)
            setTimeout(=>
                @uis.sandbox.html(@uis.photo.clone()).css("display", "block")
                html2canvas @uis.sandbox.get(0),
                    allowTaint :true,
                    useCORS    :true,
                    onrendered: (canvas) =>
                        @uis.sandbox.css("display", "none")
                        @uis.final_photo.hide().html(canvas).fadeIn(1000)
            ,2000)
        ,3000)

# EOF
