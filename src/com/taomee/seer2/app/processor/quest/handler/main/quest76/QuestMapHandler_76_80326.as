package com.taomee.seer2.app.processor.quest.handler.main.quest76 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_76_80326 extends QuestMapHandler {

    private static const idx:int = 1274;

    private static var fightNums:int = 0;


    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    private var _mc5:MovieClip;

    private var _npc:Mobile;

    private var _npc1:Mobile;

    private var mark:AcceptableMark;

    private var mark1:AcceptableMark;

    private var lightList:Vector.<MovieClip>;

    public function QuestMapHandler_76_80326(param1:QuestProcessor) {
        this.lightList = Vector.<MovieClip>([]);
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        (AnimateElementManager.getElement(1) as Teleport).visible = false;
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                MobileManager.hideMoileVec(MobileType.NPC);
                this.onDoubleMark();
            } else {
                MobileManager.hideMoileVec(MobileType.NPC);
                this.createNpc();
            }
        }
    }

    private function onComplete(param1:QuestEvent):void {
        this._mc2 = null;
        (AnimateElementManager.getElement(1) as Teleport).visible = true;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 80378);
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(400, 400));
            this._npc.resourceUrl = URLUtil.getNpcSwf(694);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this.mark = new AcceptableMark();
            this.mark.y = -120;
            this._npc.addEventListener(MouseEvent.CLICK, this.onMark);
            this._npc.addChild(this.mark);
        }
    }

    private function createNpcDouble():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(400, 400));
            this._npc.resourceUrl = URLUtil.getNpcSwf(694);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this.mark1 = new AcceptableMark();
            this.mark1.y = -70;
            this._npc.addChild(this.mark1);
        }
    }

    private function onMark(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(694, "黑武士", [[0, "该死的，这里怎么什么都没有？超能氏族密道在哪里？"]], ["你在干什么！"], [function ():void {
            NpcDialog.show(10, "巴蒂", [[0, "他在搞破坏！快制止他！"]], ["住手！"], [function ():void {
                NpcDialog.show(694, "黑武士", [[0, "凭你们也想阻止我？笑话！"]], ["那就来战！"], [function ():void {
                    FightManager.startFightWithWild(idx);
                    ++fightNums;
                    MobileManager.removeMobile(_npc, MobileType.NPC);
                    _npc = null;
                }]);
            }]);
        }]);
    }

    private function onDoubleMark():void {
        this._mc2 = _processor.resLib.getMovieClip("Mc76");
        _map.front.addChild(this._mc2);
        this._mc2.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc2, 1, this._mc2.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc2);
            createNpc1();
        }, true);
    }

    private function createNpc1():void {
        if (!this._npc1) {
            this._npc1 = new Mobile();
            this._npc1.setPostion(new Point(650, 300));
            this._npc1.resourceUrl = URLUtil.getNpcSwf(757);
            this._npc1.buttonMode = true;
            MobileManager.addMobile(this._npc1, MobileType.NPC);
            this.mark = new AcceptableMark();
            this.mark.y = -70;
            this._npc1.addEventListener(MouseEvent.CLICK, this.onMark1);
            this._npc1.addChild(this.mark);
        }
    }

    private function onMark1(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var i:int = 0;
        while (i < 3) {
            this.lightList.push(_map.content["light" + i]);
            this.lightList[i].addEventListener(MouseEvent.CLICK, this.onLight);
            i++;
        }
        NpcDialog.show(757, "萤火虫", [[0, "幸好……秘密没有被他发现……"]], ["你能告诉我们这是哪儿吗？"], [function ():void {
            NpcDialog.show(757, "萤火虫（害羞）", [[0, "这里是萤火之墓，我们的……先辈都在这里安眠。这些……萤火，就是他们的化身……"]], ["原来是这样"], [function ():void {
                NpcDialog.show(11, "多罗", [[0, "那这里和超能氏族又有什么联系呢？"]], ["黑武士说的超能氏族密道就是这里？"], [function ():void {
                    NpcDialog.show(757, "萤火虫（害羞）", [[0, "这里……还有一扇门，可以……通往超能氏族……"]], [" 真的吗？在哪儿？"], [function ():void {
                        NpcDialog.show(757, "萤火虫（害羞）", [[0, "这四周有一些灯……麻烦你们……去点亮"]], ["好"], [function ():void {
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onLight(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MovieClip(event.currentTarget).gotoAndStop(2);
        if (this.lightList[0].currentFrame == 2 && this.lightList[1].currentFrame == 2 && this.lightList[2].currentFrame == 2) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("76_1"), function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(questID, 2);
            });
        }
    }

    override public function processMapDispose():void {
        MobileManager.removeMobile(this._npc, MobileType.NPC);
        MobileManager.removeMobile(this._npc1, MobileType.NPC);
        super.processMapDispose();
    }
}
}
