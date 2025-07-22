import QtQuick 2.15
import QtQuick.Controls 2.15 as QtControls
import org.kde.kirigami 2.20 as Kirigami

Item {
    id: colorPicker
    property color selectedColor: "#ffffff"
    property string pickerTitle: "Select Color"
    signal colorPicked(color c)

    width: 220
    height: 120

    Rectangle {
        anchors.fill: parent
        color: Kirigami.Theme.backgroundColor
        border.color: Kirigami.Theme.textColor
        radius: 8

        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 8

            QtControls.Label {
                text: pickerTitle
                font.bold: true
                horizontalAlignment: Qt.AlignHCenter
                width: parent.width
            }
            
            Row {
                spacing: 10
                QtControls.Label {
                    text: i18n("Hue")
                    width: 60
                    horizontalAlignment: Qt.AlignRight
                }
                QtControls.Slider {
                    id: hueSlider
                    from: 0
                    to: 359
                    width: 150
                    value: Qt.hsla(selectedColor.hslHue, selectedColor.hslSaturation, selectedColor.hslLightness, 1).hslHue * 359
                    onValueChanged: {
                        var h = value / 359
                        colorPreview.color = Qt.hsla(h, satSlider.value, lightSlider.value, 1)
                    }
                }
            }

            Row {
                spacing: 10
                QtControls.Label {
                    text: i18n("Saturation")
                    width: 60
                    horizontalAlignment: Qt.AlignRight
                }
                QtControls.Slider {
                    id: satSlider
                    from: 0
                    to: 1
                    width: 150
                    value: selectedColor.hslSaturation
                    onValueChanged: {
                        var h = hueSlider.value / 359
                        colorPreview.color = Qt.hsla(h, value, lightSlider.value, 1)
                    }
                }
            }

            Row {
                spacing: 10
                QtControls.Label {
                    text: i18n("Lightness")
                    width: 60
                    horizontalAlignment: Qt.AlignRight
                }
                QtControls.Slider {
                    id: lightSlider
                    from: 0
                    to: 1
                    width: 150
                    value: selectedColor.hslLightness
                    onValueChanged: {
                        var h = hueSlider.value / 359
                        colorPreview.color = Qt.hsla(h, satSlider.value, value, 1)
                    }
                }
            }

            Row {
                spacing: 10
                QtControls.Label {
                    text: i18n("Preview")
                    width: 60
                    verticalAlignment: Qt.AlignVCenter
                }
                Rectangle {
                    id: colorPreview
                    width: 40; height: 40
                    anchors.margins: 10
                    color: selectedColor
                    border.color: "#888"
                    radius: 6
                }
                Rectangle {
                    // Transparent spacer
                    width: 40
                    height: 1
                    color: "transparent"
                }
                QtControls.Button {
                    text: "Pick"
                    anchors.margins: 10
                    anchors.rightMargin: 0
                    onClicked: {
                        colorPicker.selectedColor = colorPreview.color
                        colorPicker.colorPicked(colorPreview.color)
                    }
                }
            }
        }
    }
}