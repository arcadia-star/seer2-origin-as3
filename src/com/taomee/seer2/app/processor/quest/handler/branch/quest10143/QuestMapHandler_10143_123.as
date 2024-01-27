package com.taomee.seer2.app.processor.quest.handler.branch.quest10143 {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10143_123 extends QuestMapHandler {


    private var _myself:Actor;

    private var _npc_mc:MovieClip;

    private const POS:Point = new Point(350, 340);

    public function QuestMapHandler_10143_123(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isComplete(10141)) {
            if (QuestManager.isCanAccepted(_quest.id)) {
                MonsterManager.hideAllMonster();
                MobileManager.getMobile(20, MobileType.NPC).visible = false;
                this.addNpcFirst();
            }
            if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
                MonsterManager.hideAllMonster();
                MobileManager.getMobile(20, MobileType.NPC).visible = false;
                this.addNpcAgain();
            }
        }
    }

    private function addNpcFirst():void {
        if (this._npc_mc) {
            DisplayUtil.removeForParent(this._npc_mc);
        }
        this._npc_mc = _processor.resLib.getMovieClip("mc_1");
        this._npc_mc.x = this.POS.x;
        this._npc_mc.y = this.POS.y;
        this._npc_mc.buttonMode = true;
        _map.content.addChild(this._npc_mc);
        this._npc_mc.addEventListener(MouseEvent.CLICK, this.onFirst_1_Handler);
    }

    private function onFirst_1_Handler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(177, "小绿", [[0, "怎么办？怎么办？我把爸爸的宝贝精灵弄丢了，到现在还没找到。你们一定要帮帮我呀！"]], ["去找你的爸爸，我们一起想办法吧。"], [function ():void {
            NpcDialog.show(177, "小绿", [[0, "不行呀！我爸爸知道康特丢了一定饶不了我，求求你再跟我找一下吧。"]], ["好吧，那我们分头行动。"], [function ():void {
                MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10143_1"), 3, [[1, 0]], function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptComplete);
                    QuestManager.accept(_quest.id);
                });
            }]);
        }]);
    }

    private function onAcceptComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptComplete);
        this.onFirst_2_Handler(null);
    }

    private function hideMyself():void {
        this._myself = ActorManager.getActor();
        this._myself.hide();
    }

    private function addNPC():void {
        if (this._npc_mc) {
            DisplayUtil.removeForParent(this._npc_mc);
        }
        this._npc_mc = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._npc_mc);
        var _loc1_:MovieClip = this._npc_mc["suer"];
        _loc1_.buttonMode = true;
        _loc1_.addEventListener(MouseEvent.CLICK, this.onFirst_2_Handler);
    }

    private function onFirst_2_Handler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(177, "小绿", [[0, "你那边看到康特了吗？"]], ["连个影子也没有"], [function ():void {
            NpcDialog.show(177, "小绿", [[0, "完了！这下死定了。"]], ["看来只好去找你的爸爸了。"], [function ():void {
                NpcDialog.show(177, "小绿", [[0, "呜呜呜…只能这样了，第一次出雪人村没拿到多少礼物还把大白熊给弄丢了，我怎么这么倒霉呀，赛尔你一定会陪我一起去的对吧？"]], ["好吧，你的家在哪呀？"], [function ():void {
                    NpcDialog.show(177, "小绿", [[0, "我的家就在雪人村里，平时一般人是进不去的，一年只有这段时间才会把入口打开。"]], ["哦？这么神秘的地方？"], [function ():void {
                        NpcDialog.show(177, "小绿", [[0, "恩，好吧，不过你可要小心哦。我爸爸很厉害的…"]], ["嗯，知道啦，我们快走吧。"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Complete);
                            QuestManager.completeStep(_quest.id, 1);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStep1Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
        SceneManager.changeScene(SceneType.LOBBY, 10108);
    }

    private function addNpcAgain():void {
        if (this._npc_mc) {
            DisplayUtil.removeForParent(this._npc_mc);
        }
        this._npc_mc = _processor.resLib.getMovieClip("mc_1");
        this._npc_mc.x = this.POS.x;
        this._npc_mc.y = this.POS.y;
        this._npc_mc.buttonMode = true;
        _map.content.addChild(this._npc_mc);
        this._npc_mc.addEventListener(MouseEvent.CLICK, this.onFirst_2_Handler);
    }

    override public function processMapDispose():void {
        MobileManager.getMobile(20, MobileType.NPC).visible = true;
        MonsterManager.showAllMonster();
        if (this._npc_mc) {
            DisplayUtil.removeForParent(this._npc_mc);
            this._npc_mc = null;
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
    }
}
}
