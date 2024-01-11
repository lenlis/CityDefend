import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import QtGraphicalEffects 1.0
import "../scripts.js" as Scripts

Page {
    function enemyCreate() {
                var rand = Scripts.getRandomInt(1,4+(2*gameArea.gameState))
                if(rand <= 5){
                    planesModel.append({h: 150, w:117, start:-150, sp: 3, hp: 2,c: 10, img: Qt.resolvedUrl("../icons/plane.png")})
                }
                else if(rand > 5 && rand < 10){
                    big_planesModel.append({h: 300, w:300, start:-300, sp: 1, hp: 6,c: 40,  img: Qt.resolvedUrl("../icons/big_plane.png")})
                }
                else if(rand >= 10){
                    rocketsModel.append({h: 300, w:150, start:-300, sp: 5, hp: 1,c: 60, img: Qt.resolvedUrl("../icons/rocket.png")})
                }
            }
    function checkEnemyState(yCord, enemyHeight, id, model){
        if((yCord === 0 || yCord === -1 || yCord === 1)&& gameArea.gameRun){
            gameArea.enemyCreate()
        }
        else if(!gameArea.gameRun){
            startTimer.restart()
        }
        if(yCord >= gameArea.height){
            if(gameArea.baseHp>0){
                gameArea.baseHp -= 1
            }
            if(gameArea.baseHp == 0){
                planesModel.clear()
                big_planesModel.clear()
                rocketsModel.clear()
                endModel.append({})
            }
            else{
                hpBar.text = gameArea.baseHp
                model.remove(id)
            }
        }
    }
    function killEnemy(id, model, cost){
        gameArea.money+=cost
        gameArea.frags +=1
        model.remove(id)
        if(gameArea.frags === 20*gameArea.gameState){
            gameArea.gameRun = false
        }
    }

    id: gameArea

    objectName: "gamePage"
    allowedOrientations: Orientation.All

    backgroundColor: "black"
    property int zone: 400
    property int damage: 1
    property int baseHp: 1
    property int money: 0
    property bool gameRun: true
    property int frags: 0
    property int gameState: 1
    property int speed: 0
    Timer{
        id:startTimer
        interval: 3000
        repeat: false
        running: true
        onTriggered:function startStage(){
            gameArea.gameRun = true
            if(gameArea.speed < 18){
                gameArea.speed += 3
            }
            gameArea.enemyCreate()}
    }
   Image{
       anchors.top: parent.top
       anchors.left: parent.left
       height: parent.height
       width: parent.width
       source: Qt.resolvedUrl("../icons/sky.jpg")
       fillMode: Image.PreserveAspectCrop
    }

    Rectangle{
        anchors.bottom: parent.bottom
        width: parent.width
        height: zone
        color: "#2045FC00"
    }

    Image{
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: 300
        width: parent.width
        source: Qt.resolvedUrl("../icons/city.png")
        fillMode: Image.PreserveAspectCrop
     }

    ListView{
        id:planes
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        interactive: false
        delegate: Item {

                Image{
                    property int enemySpeed: sp
                    property int healPoints: hp
                    property int cost: c
                    y:start
                    x: Scripts.getRandomInt(10, gameArea.width-w-10)
                    height: h
                    width:w
                    source: img
                    fillMode: Image.Pad
                    Text{
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 - this.width/2
                        anchors.topMargin: parent.height/2
                        text: parent.healPoints
                        color: "red"
                    }

                    MouseArea{
                        anchors.top: parent.top
                        anchors.left: parent.left
                        height: parent.height
                        width: parent.width
                        onPressed: function De() {
                            if((parent.y + h) >= (gameArea.height - gameArea.zone)){
                                if(parent.healPoints - gameArea.damage <=0){
                                   killEnemy(parent.index, planesModel, parent.cost)
                                }
                                else{parent.healPoints -= gameArea.damage}
                            }
                        }

                }
                Timer{
                    interval: 20-gameArea.speed
                    repeat: true
                    running: true
                    onTriggered: function move() {
                        parent.y += parent.enemySpeed
                        checkEnemyState(parent.y, parent.height, parent.index, planesModel)
                    }
                }
            }
        }
        model: ListModel {
            id: planesModel
        }
    }

    ListView{
        id:big_planes
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        interactive: false
        delegate: Item {

                Image{
                    property int enemySpeed: sp
                    property int healPoints: hp
                    property int cost: c
                    y:start
                    x: Scripts.getRandomInt(10, gameArea.width-w-10)
                    height: h
                    width:w
                    source: img
                    fillMode: Image.Pad
                    Text{
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 - this.width/2
                        anchors.topMargin: parent.height/2
                        text: parent.healPoints
                        color: "red"
                    }

                    MouseArea{
                        anchors.top: parent.top
                        anchors.left: parent.left
                        height: parent.height
                        width: parent.width
                        onPressed: function De() {
                            if((parent.y + h) >= (gameArea.height - gameArea.zone)){
                                if(parent.healPoints - gameArea.damage <=0){
                                   killEnemy(parent.index, big_planesModel, parent.cost)
                                }
                                else{parent.healPoints -= gameArea.damage}
                            }
                        }
                }
                Timer{
                    interval: 20-gameArea.speed
                    repeat: true
                    running: true
                    onTriggered: function StarsCreate() {
                        parent.y += parent.enemySpeed
                        checkEnemyState(parent.y, parent.height, parent.index, planesModel)
                    }
                }
            }
        }
        model: ListModel {
            id: big_planesModel
        }
    }
    ListView{
        id:rockets
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        interactive: false
        delegate: Item {

                Image{
                    property int enemySpeed: sp
                    property int healPoints: hp
                    property int cost: c
                    y:start
                    x: Scripts.getRandomInt(10, gameArea.width-w-10)
                    height: h
                    width:w
                    source: img
                    fillMode: Image.Pad
                    MouseArea{
                        anchors.top: parent.top
                        anchors.left: parent.left
                        height: parent.height
                        width: parent.width
                        onPressed: function De() {
                            if((parent.y + h) >= (gameArea.height - gameArea.zone)){
                                if(parent.healPoints - gameArea.damage <=0){
                                    killEnemy(parent.index, rocketsModel, parent.cost)
                                }
                                else{parent.healPoints -= gameArea.damage}
                            }
                        }
                }
                Timer{
                    interval: 20-gameArea.speed
                    repeat: true
                    running: true
                    onTriggered: function StarsCreate() {
                        parent.y += parent.enemySpeed
                        checkEnemyState(parent.y, parent.height, parent.index, planesModel)
                    }
                }
            }
        }
        model: ListModel {
            id: rocketsModel
        }
    }



    PageHeader{

        Rectangle{
            color:"#F3F3F3"
            height: parent.height
            width: parent.width
            anchors.left: parent.left
            anchors.top: parent.top
            Row{
                spacing : 60


                Rectangle{
                    width: 20
                    height: 70
                    color: "#00000000"
                }

                Row{
                    spacing : 25
                    height: 90
                    width: 300
                    Button{
                        id:zoneButton
                        property int level: 1
                        height: 70
                        width: 70
                        text: "zone"
                        color: "blue"
                        anchors.topMargin: 10
                        property int baseCost: 200
                        highlighted: true
                        onClicked: function upgrade(){
                            if( gameArea.money >= this.baseCost*this.level && this.level < 8){
                                gameArea.zone += 100
                                gameArea.money -= this.baseCost*this.level
                                this.level +=1
                            }
                        }
                        Image {
                            source: "../icons/zoneUpgrade.png"
                            fillMode: Image.Pad
                            width: parent.width
                            height: parent.height
                            anchors.top: parent.top
                            anchors.left: parent.left
                        }
                        Text {
                            anchors.top: parent.bottom
                            anchors.topMargin: 10
                            text: parent.baseCost*parent.level + "$"
                        }
                    }
                    Button{
                        id:damageButton
                        property int level: 1
                        height: 70
                        width: 70
                        color: "blue"
                        text: "dmg"
                        anchors.topMargin: 10
                        property int baseCost: 300
                        highlighted: true
                        onClicked: function upgrade(){
                            if( gameArea.money >= this.baseCost*this.level*this.level && this.level < 3){
                                gameArea.damage += 1
                                gameArea.money -= this.baseCost*this.level*this.level
                                this.level +=1
                            }
                        }
                        Image {
                            source: "../icons/DMGupgrade.png"
                            fillMode: Image.Pad
                            width: parent.width
                            height: parent.height
                            anchors.top: parent.top
                            anchors.left: parent.left
                        }
                        Text {
                            anchors.top: parent.bottom
                            anchors.topMargin: 10
                            text: parent.baseCost*parent.level + "$"
                        }
                    }
                    Button{
                        id:hpButton
                        property int level: 1
                        height: 70
                        width: 70
                        color: "blue"
                        text:"HP"
                        anchors.topMargin: 10
                        property int baseCost: 500
                        highlighted: true
                        onClicked: function upgrade(){
                            if( gameArea.money >= this.baseCost*this.level && this.level < 3){
                                gameArea.baseHp +=1
                                gameArea.money -= this.baseCost*this.level
                                this.level +=1
                            }
                        }
                        Image {
                            source: "../icons/HPupgrade.png"
                            fillMode: Image.Pad
                            width: parent.width
                            height: parent.height
                            anchors.top: parent.top
                            anchors.left: parent.left
                        }
                        Text {
                            anchors.top: parent.bottom
                            anchors.topMargin: 10
                            text: parent.baseCost*parent.level + "$"
                        }
                    }
                }
                Image {
                    source: "../icons/HP.png"
                    fillMode: Image.Pad
                    width: 70
                    height: 70
                    Text{
                        id: hpBar
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width/2 - this.width/2
                        anchors.topMargin: parent.height/2 - this.height/2
                        text: gameArea.baseHp
                    }
                }
                Rectangle{
                    width: 140
                    height: 70
                    Text {
                        id: moneyBar
                        anchors.topMargin: parent.height/2 - this.height/2
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        text: gameArea.money + "$"
                    }
                }
            }
        }
    }
    ListView{
        id:end
        width: parent.width
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        interactive: false
        delegate: Item {
                height: gameArea.height
                width: gameArea.width

                Rectangle{
                    height: gameArea.height
                    width: gameArea.width
                    anchors.left: gameArea.left
                    anchors.top: gameArea.top
                    color: "#90202020"
                    Button{
                        id:endButton
                        height: 100
                        color: "#FFFFFFFF"
                        width: parent.width-200
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 100
                        anchors.topMargin: 300
                        onClicked: pageStack.pop()
                        Rectangle{
                            radius: 5
                            height: parent.height
                            width: parent.width
                            anchors.left: parent.left
                            anchors.top: parent.top
                            color: "#FFFFFFFF"
                            Text {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.leftMargin: parent.width/2 - this.width/2
                                anchors.topMargin: parent.height/2 - this.height/2
                                text: qsTr("Главное меню")
                            }
                        }

                    }
                }
        }
        model: ListModel {
            id: endModel
        }
    }
}
