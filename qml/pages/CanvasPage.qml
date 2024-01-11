// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause

import QtQuick 2.0

Canvas {
    id: canvas
    property string loadPath: ""
    onLoadPathChanged: canvas.loadImage(loadPath)
    onImageLoaded: {
        var ctx = getContext("2d")
        ctx.drawImage(loadPath, 0, 0)
        requestPaint()
    }
    onVisibleChanged: {
        if(visible){
            requestPaint()
        }
    }
}
