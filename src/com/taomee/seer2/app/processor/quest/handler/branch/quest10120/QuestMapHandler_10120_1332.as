package com.taomee.seer2.app.processor.quest.handler.branch.quest10120 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10118.QuestMapHandler_10118_1012;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10120_1332 extends QuestMapHandler {

    private static const FightI_Index:uint = 145;

    private static const FightII_Index:uint = 146;


    private var _sceneMc:MovieClip;

    private var _blackHat:MovieClip;

    private var _captainer:MovieClip;

    private var _stoneMc:MovieClip;

    public function QuestMapHandler_10120_1332(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id)) {
            this.initUI();
            if (!QuestManager.isStepComplete(_quest.id, 1)) {
                this.startTalkI();
            } else if (!QuestManager.isStepComplete(_quest.id, 2)) {
                this.finishStepI(null);
            } else if (!QuestManager.isStepComplete(_quest.id, 3)) {
                this.startTalkIII();
            }
        }
    }

    private function initUI():void {
        this._captainer = _processor.resLib.getMovieClip("Captain_10120");
        this._captainer.buttonMode = true;
        LayerManager.uiLayer.addChild(this._captainer);
        this._captainer.buttonMode = true;
        if (QuestManager.isStepComplete(_quest.id, 1)) {
            this._sceneMc = _processor.resLib.getMovieClip("MonsterState_10120");
            this._sceneMc = this._sceneMc["stateBody"];
            LayerManager.topLayer.addChild(this._sceneMc);
            if (!QuestManager.isStepComplete(_quest.id, 2)) {
                this.playSceneMovie(1);
            } else if (!QuestManager.isStepComplete(_quest.id, 3)) {
                this.playSceneMovie(2);
            }
        }
    }

    private function startTalkI():void {
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "（前面的人依稀是船长，但是和辛迪船长的样子又有些不同）"]], ["上去问问他"], [function ():void {
            QuestMapHandler_10118_1012.hideToolBar();
            _captainer.addEventListener(MouseEvent.CLICK, startTalkII);
        }]);
    }

    private function startTalkII(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(1, "船长", [[5, "是" + ActorManager.actorInfo.nick + "来了吗？我们就快回到火星港了，你马上可以和家人团聚了哦。"]], ["为什么要回火星？"], [function ():void {
            NpcDialog.show(1, "船长", [[5, "你难道不想回家吗？这些年的探险，付出太多，收获太少！是时候该结束了。"]], ["船长，我们还没有完成使命啊？"], [function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "船长，您教导我们不能轻言放弃的！我们还有很多使命没有完成呢！"]], ["我不甘心啊！"], [function ():void {
                    NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "你真的是辛迪船长吗？难道这又是一个梦境？"]], ["你到底是谁？？"], [function ():void {
                        (SceneManager.active as LobbyScene).hideToolbar();
                        playFullMovieI();
                    }]);
                }]);
            }]);
        }]);
    }

    private function playFullMovieI():void {
        MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/10120_1.swf"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, finishStepI);
            QuestManager.completeStep(_quest.id, 1);
        });
    }

    private function finishStepI(param1:QuestEvent):void {
        var fightIndex:int;
        var event:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.finishStepI);
        fightIndex = int(FightManager.currentFightRecord.initData.positionIndex);
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightI_Index == fightIndex) {
                MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/10120_2.swf"), function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, playSceneMc);
                    QuestManager.completeStep(_quest.id, 2);
                });
            }
        } else {
            this.fightIHandler();
        }
    }

    private function fightIHandler():void {
        FightManager.startFightWithWild(FightI_Index);
        FightManager.addEventListener(FightStartEvent.START_ERROR, this.onFightIStartError);
        FightManager.addEventListener(FightStartEvent.START_SUCCESS, this.onFightIStartOk);
    }

    private function onFightIStartOk(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onFightIStartError);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onFightIStartOk);
    }

    private function onFightIStartError(param1:FightStartEvent):void {
        PetAvatarPanel.show();
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onFightIStartError);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onFightIStartOk);
        this.fightIHandler();
    }

    private function playBlackHatMovie():void {
        this._blackHat = _processor.resLib.getMovieClip("BlackSmoke_10120");
        LayerManager.uiLayer.addChild(this._blackHat);
        this._blackHat.x = ActorManager.getActor().x + 40;
        this._blackHat.y = ActorManager.getActor().y - 200;
        this.playSceneMovie(2);
    }

    private function playSceneMc(param1:QuestEvent = null):void {
        var event:QuestEvent = param1;
        DisplayUtil.removeForParent(this._captainer);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.playSceneMc);
        this.playBlackHatMovie();
        NpcDialog.show(150, "赛尔影子", [[0, "像你这样的家伙还想拯救阿卡迪亚星？别做梦了！你是赢不了我的！"]], ["我绝不会放弃！"], [function ():void {
            (SceneManager.active as LobbyScene).hideToolbar();
            fightIIHandler();
        }]);
    }

    private function onFightStartOk(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onFightStartError);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onFightStartOk);
    }

    private function onFightStartError(param1:FightStartEvent):void {
        PetAvatarPanel.show();
        this.fightIIHandler();
    }

    private function fightIIHandler():void {
        FightManager.startFightWithWild(FightII_Index);
        FightManager.addEventListener(FightStartEvent.START_ERROR, this.onFightStartError);
        FightManager.addEventListener(FightStartEvent.START_SUCCESS, this.onFightStartOk);
    }

    private function startTalkIII():void {
        DisplayUtil.removeForParent(this._blackHat);
        this.playSceneMovie(1);
        NpcDialog.show(511, "暗影系守护兽", [[0, "不可能！你应该会生生世世都活在这场恶梦中！"]], ["邪不胜正"], [function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "我不怕你！不论再来多少次，我都会一样把你击败的！"]], ["滚出我的梦！"], [function ():void {
                (SceneManager.active as LobbyScene).hideToolbar();
                disappearMonster();
            }]);
        }]);
    }

    private function disappearMonster():void {
        var mc:MovieClip = null;
        DisplayObjectUtil.removeFromParent(this._captainer);
        mc = this._sceneMc["mc3"] as MovieClip;
        this.playSceneMovie(3);
        mc.gotoAndPlay(1);
        mc.addFrameScript(mc.totalFrames - 1, function ():void {
            mc.stop();
            DisplayUtil.removeForParent(_sceneMc);
            showStone();
        });
    }

    private function playFullMovieIII():void {
        MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/10120_3.swf"), function ():void {
        });
    }

    protected function clickStone(param1:MouseEvent):void {
        this._stoneMc.removeEventListener(MouseEvent.CLICK, this.clickStone);
        ModuleManager.toggleModule(URLUtil.getAppModule("StonePanel"), "打开中...", {
            "toHome": true,
            "completeQuestId": 10120,
            "completeStep": 3
        });
    }

    private function playSceneMovie(param1:int = 1):void {
        var _loc2_:int = 1;
        while (_loc2_ <= 3) {
            (this._sceneMc["mc" + _loc2_] as MovieClip).visible = false;
            _loc2_++;
        }
        (this._sceneMc["mc" + param1] as MovieClip).visible = true;
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DisplayObjectUtil.removeFromParent(this._sceneMc);
        DisplayObjectUtil.removeFromParent(this._captainer);
        DisplayObjectUtil.removeFromParent(this._blackHat);
    }

    protected function showStone():void {
        this._stoneMc = _processor.resLib.getMovieClip("stoneMc");
        this._stoneMc.buttonMode = true;
        _map.front.addChild(this._stoneMc);
        MovieClipUtil.playMc(this._stoneMc, 1, this._stoneMc.totalFrames, function ():void {
            _stoneMc.gotoAndStop(_stoneMc.totalFrames);
            _stoneMc.addEventListener(MouseEvent.CLICK, clickStone);
        });
    }
}
}
