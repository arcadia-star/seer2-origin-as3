package com.taomee.seer2.app.processor.quest.handler.story.quest50 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_50_570 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    public function QuestMapHandler_50_570(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.initMc();
        }
    }

    private function initMc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.NpcTalkHandler);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
    }

    private function NpcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(122, "派瑞", [[0, "虽说要去救大家，但是我完全不知道大家的下落。文森特那家伙，莫非又躲到某个阴暗的小角落去酝酿灵感了？"]], ["应该也和你一样被冰封了吧？"], [function ():void {
            NpcDialog.show(486, "詹姆斯", [[0, "唔——唔唔！！%……#@￥&*！！（哼哼唧唧了一大堆。）"]], ["完全听不懂啊=。="], [function ():void {
                NpcDialog.show(122, "派瑞", [[1, "哦哦！！你说冰脊山脉？果然是适合文森特的地方！他很容易和苍凉的景象产生共鸣呢！"]], ["……那我们去冰脊山脉找找吧！"], [function ():void {
                    _mc_0.removeEventListener(MouseEvent.CLICK, NpcTalkHandler);
                    QuestManager.addEventListener(QuestEvent.ACCEPT, AcceptHandler);
                    QuestManager.accept(_quest.id);
                }]);
            }]);
        }]);
    }

    private function AcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 620);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
    }
}
}
