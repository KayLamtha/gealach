/*
 * Copyright 2017  koffeinfriedhof <koffeinfriedhof@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.15
import QtQuick.Layouts 1.15 as QtLayouts
import QtQuick.Controls 2.15 as QtControls
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.core as PlasmaCore

Item {
    id: root

    property alias cfg_backgroundColor: _preview.color
    property alias cfg_primaryFontColor:    _pri.color
    property alias cfg_secondaryFontColor:  _sec.color

    function safeColor(val) {
        // Accepts valid hex or named color, else returns white
        if (val && Qt.colorEqual(val, val)) return val;
        return "#ffffff";
    }

    QtLayouts.GridLayout {
        columns: 4

        QtControls.Label { text: i18n("Primary Font Color") }
        QtControls.TextField {
            id: _priField
            onTextChanged: _pri.color = text
            Component.onCompleted: text = cfg_primaryFontColor
        }
        Rectangle {
            width: 24; height: 24
            radius: 6
            color: safeColor(_priField.text)
            border.color: Kirigami.Theme.textColor
            QtLayouts.Layout.alignment: Qt.AlignVCenter
        }
        QtControls.Button {
            text: i18n("Pick")
            onClicked: {
                colorPickerPri.selectedColor = safeColor(_priField.text)
                colorPickerPriPopup.open()
            }
        }
        QtControls.Popup {
            id: colorPickerPriPopup
            modal: true
            focus: true
            width: 300
            height: 220
            parent: root
            x: (parent.width - width) / 2

            ColorPicker {
                id: colorPickerPri
                pickerTitle: i18n("Select Primary Color")
                anchors.fill: parent
                visible: true
                onColorPicked: {
                    _priField.text = colorPickerPri.selectedColor
                    colorPickerPriPopup.close()
                }
            }
        }
        
        QtControls.Label { text: i18n("Secondary Font Color") }
        QtControls.TextField {
            id: _secField
            onTextChanged: _sec.color = text
            Component.onCompleted: text = cfg_secondaryFontColor
        }
        Rectangle {
            width: 24; height: 24
            radius: 6
            color: safeColor(_secField.text)
            border.color: Kirigami.Theme.textColor
            QtLayouts.Layout.alignment: Qt.AlignVCenter
        }
        QtControls.Button {
            text: i18n("Pick")
            onClicked: {
                colorPickerSec.selectedColor = safeColor(_secField.text)
                colorPickerSecPopup.open()
            }
        }
        QtControls.Popup {
            id: colorPickerSecPopup
            modal: true
            focus: true
            width: 300
            height: 220
            parent: root
            x: (parent.width - width) / 2

            ColorPicker {
                id: colorPickerSec
                pickerTitle: i18n("Select Secondary Color")
                visible: true
                anchors.fill: parent
                onColorPicked: {
                    _secField.text = selectedColor
                    colorPickerSecPopup.close()
                }
            }
        }

        QtControls.Label { text: i18n("Background Color") }
        QtControls.TextField {
            id: _bgcField
            onTextChanged: _preview.color = text
            Component.onCompleted: text = cfg_backgroundColor
        }
        Rectangle {
            width: 24; height: 24
            radius: 6
            color: safeColor(_bgcField.text)
            border.color: Kirigami.Theme.textColor
            QtLayouts.Layout.alignment: Qt.AlignVCenter
        }
        QtControls.Button {
            text: i18n("Pick")
            onClicked: {
                colorPickerBg.selectedColor = safeColor(_bgcField.text)
                colorPickerBgPopup.open()
            }
        }
        QtControls.Popup {
            id: colorPickerBgPopup
            modal: true
            focus: true
            width: 300
            height: 220
            parent: root
            x: (parent.width - width) / 2

            ColorPicker {
                id: colorPickerBg
                pickerTitle: i18n("Select Background Color")
                visible: true
                anchors.fill: parent
                onColorPicked: {
                    _bgcField.text = selectedColor
                    colorPickerBgPopup.close()
                }
            }
        }

        QtControls.Label { text: i18n("Preview") }
        Rectangle {
            id: _preview
            height: 60
            width: 200
            color: _bgcField.text
            QtLayouts.Layout.columnSpan: 3

            Column {
                QtControls.Label {
                    id: _pri
                    text: i18n("Primary Font Color")
                    color: _priField.text
                }
                QtControls.Label {
                    id: _sec
                    text: i18n("Secondary Font Color")
                    color: _secField.text
                }
            }
        }
    }
}