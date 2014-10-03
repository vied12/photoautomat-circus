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
        @CONFIG =
            default_size : [640, 480]

        @is_ready = no

    bindUI: =>
        that = this
        @sayCheese = new SayCheese(@ui.get(0), audio: false)
        @sayCheese.on "start", ->
            that.is_ready = yes
        @sayCheese.on("snapshot", @onSnapshotTaken)
        @sayCheese.start()

    onSnapshotTaken: (canvas) =>
        @callback(canvas)
        @callback = null

    takeSnapshot: (callback) =>
        @callback = callback
        if @is_ready
            @sayCheese.takeSnapshot(@CONFIG.default_size[0], @CONFIG.default_size[1])
        else
            setTimeout(@takeSnapshot, 200)

# EOF
