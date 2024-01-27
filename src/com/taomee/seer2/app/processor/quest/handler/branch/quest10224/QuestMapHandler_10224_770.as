package com.taomee.seer2.app.processor.quest.handler.branch.quest10224 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10224_770 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mack:AcceptableMark;

    public function QuestMapHandler_10224_770(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10224) && QuestManager.isStepComplete(10224, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        MobileManager.getMobile(80, MobileType.NPC).visible = false;
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        this._mc1["yuse"].visible = false;
        this._mc1.x = 150;
        this._mc1.y = 180;
        _map.front.addChild(this._mc1);
        MovieClipUtil.playMc(this._mc1, 2, this._mc1.totalFrames, function ():void {
            _mack = new AcceptableMark();
            _mack.x = _mc1["yuse"].x + 30;
            _mack.y = _mc1["yuse"].y;
            _mc1.addChild(_mack);
            _mc1["yuse"].visible = true;
            _mc1["yuse"].buttonMode = true;
            _mc1["yuse"].addEventListener(MouseEvent.CLICK, onClick);
        }, true);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc1["yuse"].removeEventListener(MouseEvent.CLICK, this.onClick);
        NpcDialog.show(591, "约瑟", [[0, "嘿！大家好~我是约瑟王，大家可以叫我约瑟，也可以叫我王哟~"]], [" 王！你好！"], [function ():void {
            NpcDialog.show(591, "约瑟", [[0, "哈哈，那么多年了，终于呼吸到了新鲜空气，心情好好好好好~~~~舒畅!"]], ["约瑟王意外的开心呢!"], [function ():void {
                NpcDialog.show(591, "约瑟", [[0, "咳咳，要办正事了——在阿卡迪亚的所有生物！我有话要说哦！要仔细听好啦"]], ["恩恩，认真听讲!"], [function ():void {
                    DisplayUtil.removeForParent(_mack);
                    DisplayUtil.removeForParent(_mc1);
                    initStep2();
                }]);
            }]);
        }]);
    }

    private function initStep2():void {
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        this._mc2["yuse"].visible = false;
        this._mc2.x = 100;
        this._mc2.y = 120;
        _map.front.addChild(this._mc2);
        MovieClipUtil.playMc(this._mc2, 2, this._mc2.totalFrames, function ():void {
            _mc2["yuse"].visible = true;
            _mack = new AcceptableMark();
            _mack.x = _mc2["yuse"].x + 30;
            _mack.y = _mc2["yuse"].y - 15;
            _mc2.addChild(_mack);
            _mc2["yuse"].buttonMode = true;
            _mc2["yuse"].addEventListener(MouseEvent.CLICK, onClick2);
        }, true);
    }

    private function onClick2(param1:MouseEvent):void {
        this.initStep3();
    }

    private function initStep3():void {
        NpcDialog.show(400, ActorManager.actorInfo.nick + "", [[0, "约瑟！你把他们都吸到哪里去了!"]], ["还我战神联盟！"], [function ():void {
            NpcDialog.show(591, "约瑟", [[0, "听着，阿卡迪亚正面临着前所未有的灾难。"]], ["灾难？"], [function ():void {
                NpcDialog.show(591, "约瑟", [[0, "没错，真正的灾难，纯粹的灾难，不可避免的灾难。"]], ["好像有大事要发生！"], [function ():void {
                    NpcDialog.show(591, "约瑟", [[0, "记住，“至暗的反面是真理！”"]], ["至暗的反面是真理？"], [function ():void {
                        NpcDialog.show(591, "约瑟", [[0, "今天就先到这吧，我要去呼吸新鲜空气咯！久违的……阿卡迪亚……先再见咯"]], ["约瑟别走啊！"], [function ():void {
                            DisplayUtil.removeForParent(_mack);
                            DisplayUtil.removeForParent(_mc2);
                            initStep4();
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep4():void {
        this._mc3 = _processor.resLib.getMovieClip("mc3");
        this._mc3.x = 40;
        this._mc3.y = 60;
        _map.front.addChild(this._mc3);
        MovieClipUtil.playMc(this._mc3, 2, this._mc3.totalFrames, function ():void {
            DisplayUtil.removeForParent(_mc3);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10224_1"), function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(10224, 1);
            }, true, true);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 20);
    }

    override public function processMapDispose():void {
        MobileManager.getMobile(80, MobileType.NPC).visible = true;
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mc3);
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mack);
    }
}
}
