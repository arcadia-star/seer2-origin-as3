package com.taomee.seer2.app.processor.quest.handler.branch.quest10214 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

public class QuestMapHandler_10214_80100 extends QuestMapHandler {

    private static const FIGHT_INDEX:int = 54;


    private var pkMovie:MovieClip;

    private var movie3:MovieClip;

    private var npc1:MovieClip;

    private var _setTime:int;

    public function QuestMapHandler_10214_80100(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(10214, 2) == true && QuestManager.isComplete(10214) == false) {
            this.onStep2();
        } else if (SceneManager.prevSceneType == SceneType.ARENA) {
            NpcDialog.show(680, "亚伦", [[0, "魔王啊！复苏吧！我们已经收集到了足够多的精灵精元！"]], ["什么！半兽人原来不是真正的魔王！那……"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2);
                QuestManager.completeStep(10214, 2);
            }]);
        } else {
            this.pkMovie = _processor.resLib.getMovieClip("pkMovie");
            LayerManager.topLayer.addChild(this.pkMovie);
            MovieClipUtil.playMc(this.pkMovie, 2, this.pkMovie.totalFrames, function ():void {
                pkMovie.gotoAndStop(pkMovie.totalFrames);
                pkMovie.addEventListener(MouseEvent.CLICK, onPk);
            });
        }
    }

    private function onPk(param1:MouseEvent):void {
        this.pkMovie.removeEventListener(MouseEvent.CLICK, this.onPk);
        if (PetInfoManager.canCure() == true) {
            this.recoverAllPetBagPet();
        } else {
            this.startFight();
        }
    }

    private function startFight():void {
        if (this.pkMovie) {
            DisplayObjectUtil.removeFromParent(this.pkMovie);
        }
        if (this._setTime) {
            clearTimeout(this._setTime);
        }
        FightManager.startFightWithNPC(FIGHT_INDEX);
    }

    private function recoverAllPetBagPet():void {
        Connection.addCommandListener(CommandSet.TREAT_ALL_PET_1215, this.onAddAllPetBlood);
        Connection.send(CommandSet.TREAT_ALL_PET_1215);
    }

    private function onAddAllPetBlood(param1:MessageEvent):void {
        var _loc3_:PetInfo = null;
        var _loc4_:int = 0;
        Connection.removeCommandListener(CommandSet.TREAT_ALL_PET_1215, this.onAddAllPetBlood);
        var _loc2_:Vector.<PetInfo> = PetInfoManager.getAllBagPetInfo();
        for each(_loc3_ in _loc2_) {
            _loc3_.hp = _loc3_.maxHp;
            PetInfoManager.dispatchEvent(PetInfoEvent.PET_PROPERTIES_CHANGE, _loc3_);
        }
        _loc4_ = int(param1.message.getRawData().readUnsignedInt());
        ActorManager.actorInfo.coins = _loc4_;
        this._setTime = setTimeout(this.startFight, 1000);
    }

    private function onStep2(param1:QuestEvent = null):void {
        var e:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2);
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10214_2"), function ():void {
            NpcDialog.show(680, "亚伦", [[0, "魔王！万岁万岁万万岁！"]], ["这……这不是《赛尔号大电影》里的库贝萨？"], [function ():void {
                NpcDialog.show(665, "迪克", [[0, "我记得！是你！还我哥哥来!"]], ["迪克小心啊！"], [function ():void {
                    movie3 = _processor.resLib.getMovieClip("movie3");
                    if (movie3) {
                        _map.content.addChild(movie3);
                        MovieClipUtil.playMc(movie3, 1, movie3.totalFrames, function ():void {
                            DisplayObjectUtil.removeFromParent(movie3);
                            movie3 = null;
                            npc1 = _processor.resLib.getMovieClip("npc1");
                            if (npc1) {
                                _map.content.addChild(npc1);
                                npc1.mouseChildren = npc1.mouseEnabled = false;
                            }
                            NpcDialog.show(680, "亚伦", [[0, "魔王大人，您已经复活了！什么时候将我转化成人呢？"]], ["……"], [function ():void {
                                NpcDialog.show(679, "库贝萨", [[0, "你这个半人半兽的畸形体，你以为你真的可以变成人吗？下辈子吧！"]], ["他……他这是要干嘛！"], [function ():void {
                                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10214_4"), function ():void {
                                        QuestManager.completeStep(10214, 3);
                                        if (npc1) {
                                            DisplayObjectUtil.removeFromParent(npc1);
                                        }
                                    });
                                }]);
                            }]);
                        });
                    }
                }]);
            }]);
        });
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this.movie3) {
            DisplayObjectUtil.removeFromParent(this.movie3);
        }
        if (this._setTime) {
            clearTimeout(this._setTime);
        }
        if (this.npc1) {
            DisplayObjectUtil.removeFromParent(this.npc1);
        }
    }
}
}
