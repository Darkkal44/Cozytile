import QtQuick 2.15
import Qt5Compat.GraphicalEffects 1.0
import SddmComponents 2.0

Rectangle {
    id: container
    width: 640
    height: 480

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: sessionModel.lastIndex

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        function onLoginSucceeded() {
            errorMessage.color = "#a6e3a1" // Green
            errorMessage.text = textConstants.loginSucceeded
        }

        function onLoginFailed() {
            password.text = ""
            errorMessage.color = "#f38ba8" // Red
            errorMessage.text = textConstants.loginFailed
        }
        
        function onInformationMessage(message) {
            errorMessage.color = "#f38ba8" // Red
            errorMessage.text = message
        }
    }

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    // Transparent login panel
    Rectangle {
        id: loginPanel
        width: 320
        height: 520
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        radius: 20

        Column {
            anchors.centerIn: parent
            spacing: 25
            width: parent.width * 0.8

            // Time and Date
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5

                Text {
                    id: timeText
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#607767" // Primary Accent
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 72
                    font.weight: Font.Light
                    font.letterSpacing: -2

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: {
                            timeText.text = Qt.formatTime(new Date(), "hh:mm")
                        }
                    }
                    Component.onCompleted: timeText.text = Qt.formatTime(new Date(), "hh:mm")
                }

                Text {
                    id: dateText
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#7a9181" // Secondary Accent
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 14
                    font.letterSpacing: 1
                    leftPadding: 1
                    font.capitalization: Font.AllUppercase
                    
                    Timer {
                        interval: 1000 * 60 * 60
                        running: true
                        repeat: true
                        onTriggered: {
                            dateText.text = Qt.formatDate(new Date(), "dddd, MMMM d")
                        }
                    }
                    Component.onCompleted: dateText.text = Qt.formatDate(new Date(), "dddd, MMMM d")
                }
            }

            // User Input
            Column {
                width: parent.width
                spacing: 8

                Rectangle {
                    width: parent.width
                    height: 44
                    color: Qt.rgba(255, 255, 255, 0.05)
                    radius: 8
                    border.color: name.activeFocus ? "#607767" : "transparent"
                    border.width: 1

                    TextInput {
                        id: name
                        anchors.fill: parent
                        anchors.margins: 12
                        verticalAlignment: TextInput.AlignVCenter
                        text: userModel.lastUser
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 14
                        color: "#607767"
                        clip: true

                        KeyNavigation.backtab: rebootButton
                        KeyNavigation.tab: password

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                password.forceActiveFocus()
                                event.accepted = true
                            }
                        }
                    }
                }
            }

            // Password Input
            Column {
                width: parent.width
                spacing: 8

                Rectangle {
                    width: parent.width
                    height: 44
                    color: Qt.rgba(255, 255, 255, 0.05)
                    radius: 8
                    border.color: password.activeFocus ? "#607767" : "transparent"
                    border.width: 1

                    TextInput {
                        id: password
                        anchors.fill: parent
                        anchors.margins: 12
                        verticalAlignment: TextInput.AlignVCenter
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 15
                        font.letterSpacing: 4
                        color: "#607767"
                        echoMode: TextInput.Password
                        clip: true

                        Text {
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            color: "#7a9181"
                            text: "Password..."
                            font.family: "JetBrains Mono Nerd Font"
                            font.pixelSize: 14
                            visible: !password.text && !password.activeFocus
                        }

                        KeyNavigation.backtab: name
                        KeyNavigation.tab: loginBtnRect

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                            }
                        }
                    }
                }

                Text {
                    id: errorMessage
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    color: "#f38ba8"
                    font.pixelSize: 12
                    height: text === "" ? 0 : implicitHeight
                    Behavior on height { NumberAnimation { duration: 200 } }
                }
            }

            // Login Button (Full Width)
            Rectangle {
                id: loginBtnRect
                width: parent.width
                height: 44
                color: loginMouseArea.pressed ? "#4b5d51" : (loginMouseArea.containsMouse ? "#7a9181" : "#607767")
                radius: 8

                Text {
                    anchors.centerIn: parent
                    text: "LOGIN"
                    color: "#1e1e2e"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    font.letterSpacing: 2
                    leftPadding: 2
                }

                MouseArea {
                    id: loginMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: sddm.login(name.text, password.text, sessionIndex)
                }
                
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
                        sddm.login(name.text, password.text, sessionIndex)
                    }
                }

                KeyNavigation.backtab: password
                KeyNavigation.tab: sessionSelector
            }

            // Hidden helper to extract session names using model.name (only works in delegate context)
            ListView {
                id: sessionNameHelper
                model: sessionModel
                currentIndex: sessionIndex
                visible: false
                width: 0
                height: 0
                delegate: Item {
                    property string sessionName: model.name || ""
                }
            }

            // Custom Themed Session Selector
            Item {
                id: sessionSelector
                width: parent.width
                height: 40
                z: 10

                // The closed "button" appearance
                Rectangle {
                    id: sessionBtn
                    width: parent.width
                    height: 40
                    radius: 8
                    color: sessionSelectorMouse.containsMouse ? Qt.rgba(255,255,255,0.1) : Qt.rgba(255,255,255,0.05)
                    border.color: sessionSelectorMouse.containsMouse || sessionList.visible ? "#607767" : Qt.rgba(255,255,255,0.15)
                    border.width: 1

                    // Session name label — reads from hidden ListView delegate
                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        text: sessionNameHelper.currentItem ? sessionNameHelper.currentItem.sessionName : "Select Session"
                        color: "#607767"
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 13
                    }

                    // Dropdown arrow
                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        text: sessionList.visible ? "▲" : "▼"
                        color: "#7a9181"
                        font.pixelSize: 11
                    }

                    MouseArea {
                        id: sessionSelectorMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: sessionList.visible = !sessionList.visible
                    }
                }

                // The popup dropdown list — opens DOWNWARD
                Rectangle {
                    id: sessionList
                    visible: false
                    width: parent.width
                    height: Math.min(sessionModel.rowCount() * 36, 150)
                    anchors.top: sessionBtn.bottom
                    anchors.topMargin: 4
                    radius: 8
                    color: Qt.rgba(240/255, 240/255, 245/255, 0.98)  // Light background
                    border.color: "#607767"
                    border.width: 1
                    clip: true

                    ListView {
                        id: sessionListView
                        anchors.fill: parent
                        anchors.margins: 4
                        model: sessionModel
                        currentIndex: sessionIndex

                        delegate: Rectangle {
                            width: sessionListView.width
                            height: 36
                            radius: 6
                            color: sessionItemMouse.containsMouse ? Qt.rgba(0,0,0,0.08) : (index === sessionIndex ? Qt.rgba(0,0,0,0.05) : "transparent")

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: model.name || model.display || ""
                                color: "#1e1e2e"
                                font.family: "JetBrains Mono Nerd Font"
                                font.pixelSize: 13
                                font.weight: index === sessionIndex ? Font.Medium : Font.Normal
                            }

                            // Checkmark for selected
                            Text {
                                visible: index === sessionIndex
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                text: "✓"
                                color: "#607767"
                                font.pixelSize: 12
                            }

                            MouseArea {
                                id: sessionItemMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    sessionIndex = index
                                    sessionList.visible = false
                                }
                            }
                        }
                    }
                }

                // (clicking anywhere outside closes the popup via z-ordering)

                KeyNavigation.backtab: loginBtnRect
                KeyNavigation.tab: shutdownButton
            }

            // Power Controls
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Item {
                    width: 36
                    height: 36
                    Rectangle {
                        id: shutdownButton
                        anchors.fill: parent
                        radius: 8
                        color: shutdownMouse.pressed ? "#4b5d51" : (shutdownMouse.containsMouse ? "#7a9181" : "#607767")

                        Text {
                            anchors.centerIn: parent
                            text: ""
                            color: "#1e1e2e"
                            font.family: "JetBrains Mono Nerd Font"
                            font.pixelSize: 18
                        }

                        MouseArea {
                            id: shutdownMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: sddm.powerOff()
                        }
                        
                        KeyNavigation.backtab: loginBtnRect
                        KeyNavigation.tab: rebootButton
                    }
                }

                Item {
                    width: 36
                    height: 36
                    Rectangle {
                        id: rebootButton
                        anchors.fill: parent
                        radius: 8
                        color: rebootMouse.pressed ? "#4b5d51" : (rebootMouse.containsMouse ? "#7a9181" : "#607767")

                        Text {
                            anchors.centerIn: parent
                            text: ""
                            color: "#1e1e2e"
                            font.family: "JetBrains Mono Nerd Font"
                            font.pixelSize: 18
                        }

                        MouseArea {
                            id: rebootMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: sddm.reboot()
                        }
                        
                        KeyNavigation.backtab: shutdownButton
                        KeyNavigation.tab: name
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (name.text == "")
            name.forceActiveFocus()
        else
            password.forceActiveFocus()
    }
}
