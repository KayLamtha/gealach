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
import org.kde.plasma.components 3.0 as PlasmaComponents

import "../code/phases.js" as Phases
import "../code/lunacalc.js" as LunaCalc

QtLayouts.ColumnLayout {
    id: fullRoot
    anchors.centerIn: parent
    spacing: Kirigami.Units.smallSpacing
    QtLayouts.Layout.minimumWidth: coll.width > btr.width ? coll.width : btr.width + Kirigami.Units.smallSpacing * 5
    QtLayouts.Layout.minimumHeight: wolf.height + coll.height + btr.height + Kirigami.Units.smallSpacing * 5

    /** PROPERTIES **/
    property var displayPhase: LunaCalc.getTodayPhases()

    /** FUNCTIONS **/
    function formatDate(str) {
        if( dateFormat==99 )
            return Qt.formatDateTime(str, dateFormatString)

            return Qt.formatDateTime(str, dateFormat)
    }

    /** ACTIONS **/
    QtControls.Action {
        id: actionPrev
        // i18n: Last/previous phase of the moon
        text: buttonTextVisible ? i18n("Prev") : ""
        shortcut: "Left"
        onTriggered: { displayPhase=LunaCalc.getPreviousPhases() }
    }

    QtControls.Action {
        id: actionNext
        // i18n: Next phase of the moon
        text: buttonTextVisible ? i18n("Next") : ""
        shortcut: "Right"
        onTriggered: { displayPhase=LunaCalc.getNextPhases() }
    }

    QtControls.Action {
        id: actionCurrent
        // i18n: current phase of the moon
        text: buttonTextVisible ? i18n("Current Phase") : ""
        shortcut: "Up"
        onTriggered: { displayPhase=LunaCalc.getTodayPhases() }
    }

    /** CONTENT **/
    Row {
        id: wolf

        visible: currentPhase.number == 14

        width: visible ? fullRoot.width : 0

        PlasmaComponents.Label {
            height: wolf.height
            // i18n: shouting title on full-moon!
            text: i18n("TODAY IS FULL-MOON!");
            color: primaryFontColor
            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.5
        }

        Image {
            height: wolf.height
            width: height
            source: (plasmoid.packagePath ? plasmoid.packagePath + "/images/werewolf.png"
                            : "../images/werewolf.png")
        }

        Component.onCompleted: height=visible ? coll.height*0.75 : 0
    }
    QtLayouts.GridLayout {
        id: coll
        columns: 3
        columnSpacing: Kirigami.Units.smallSpacing * 4
        QtLayouts.Layout.margins: Kirigami.Units.smallSpacing * 2

        Image { source: (plasmoid.packagePath ? plasmoid.packagePath + "/images/luna-gskbyte0.svg"
                            : "../images/luna-gskbyte0.svg") }
        PlasmaComponents.Label { text: phaseNames[0]; color: secondaryFontColor }
        PlasmaComponents.Label { text: formatDate(displayPhase[0]); color: primaryFontColor }

        Image { source: (plasmoid.packagePath ? plasmoid.packagePath + "/images/luna-gskbyte7.svg"
                            : "../images/luna-gskbyte7.svg"); rotation: hemisphere  ? 0 : 180 }
        PlasmaComponents.Label { text: phaseNames[1]; color: secondaryFontColor }
        PlasmaComponents.Label { text: formatDate(displayPhase[1]); color: primaryFontColor }

        Image { source: (plasmoid.packagePath ? plasmoid.packagePath + "/images/luna-gskbyte14.svg"
                            : "../images/luna-gskbyte14.svg") }
        PlasmaComponents.Label { text: phaseNames[2]; color: secondaryFontColor }
        PlasmaComponents.Label { text: formatDate(displayPhase[2]); color: primaryFontColor }

        Image { source: (plasmoid.packagePath ? plasmoid.packagePath + "/images/luna-gskbyte21.svg"
                            : "../images/luna-gskbyte21.svg"); rotation: hemisphere  ? 0 : 180 }
        PlasmaComponents.Label { text: phaseNames[3]; color: secondaryFontColor }
        PlasmaComponents.Label { text: formatDate(displayPhase[3]); color: primaryFontColor }

        Image { source: (plasmoid.packagePath ? plasmoid.packagePath + "/images/luna-gskbyte28.svg"
                            : "../images/luna-gskbyte28.svg") }
        PlasmaComponents.Label { text: phaseNames[4]; color: secondaryFontColor }
        PlasmaComponents.Label { text: formatDate(displayPhase[4]); color: primaryFontColor }

    }

    QtLayouts.RowLayout {
        id: btr

        spacing: Kirigami.Units.smallSpacing * 3
        QtLayouts.Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        QtLayouts.Layout.margins: Kirigami.Units.smallSpacing

        PlasmaComponents.Button {
            icon.name: "draw-arrow-back"
            action: actionPrev
            QtControls.ToolTip {
                text: i18n("Show previous moon phase. (Key:Left)")
            }
        }
        PlasmaComponents.Button {
            icon.name: "draw-arrow-up"
            action: actionCurrent
            QtControls.ToolTip {
                text: i18n("Show current moon phase. (Key:Up)")
            }
        }
        PlasmaComponents.Button {
            icon.name: "draw-arrow-forward"
            action: actionNext
            QtControls.ToolTip {
                text: i18n("Show next moon phase. (Key:Right)")
            }
        }
    }
}
