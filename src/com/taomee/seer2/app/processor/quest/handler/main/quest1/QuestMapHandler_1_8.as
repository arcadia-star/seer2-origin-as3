package com.taomee.seer2.app.processor.quest.handler.main.quest1 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_1_8 extends QuestMapHandler {


    private var _mc1_0:MovieClip;

    private var _mc0:MovieClip;

    private var _toolBar:MovieClip;

    private var _mapMC:MovieClip;

    private var _rightMC:MovieClip;

    private var _isShowPanel:Boolean;

    private var _mc1_1:MovieClip;

    private var _mc1_2:MovieClip;

    private var _mc1_3:MovieClip;

    public function QuestMapHandler_1_8(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        ActorManager.showRemoteActor = false;
        this._toolBar = _map.front["toolbar"];
        if (_quest.isStepCompletable(1)) {
            this.processStep1();
            StatisticsManager.newSendNovice("新手引导", "2014上半年版新手引导", "传送至教官室（加载完成）");
        }
    }

    private function processStep1():void {
        this._mc0 = UIManager.getMovieClip("NewGudie_MC");
        _map.front.addChild(this._mc0);
        this._mc0.addEventListener(MouseEvent.CLICK, this.onSelectPetClick);
        this._mc0.buttonMode = true;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("1_1"), function ():void {
        });
    }

    private function hideMC0():void {
        if (this._mc0) {
            this._mc0.removeEventListener(MouseEvent.CLICK, this.onSelectPetClick);
            DisplayObjectUtil.removeFromParent(this._mc0["mcmc"]);
        }
    }

    private function onSelectPetClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._mc1_1 = _processor.resLib.getMovieClip("mc1_1");
        _map.content.addChild(this._mc1_1);
        this._mc1_1["txt"].text = ActorManager.actorInfo.id + "你终于苏醒了！欢迎来到赛尔号II";
        MovieClipUtil.playClickMc(this._mc1_1, 1, this._mc1_1.totalFrames, function ():void {
            _mc1_2 = _processor.resLib.getMovieClip("mc1_2");
            _map.content.addChild(_mc1_2);
            MovieClipUtil.playMc(_mc1_2, 2, _mc1_2.totalFrames, function ():void {
                _mc1_3 = _processor.resLib.getMovieClip("mc1_3");
                _map.content.addChild(_mc1_3);
                MovieClipUtil.playClickMc(_mc1_3, 1, _mc1_3.totalFrames, function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                    QuestManager.completeStep(_quest.id, 1);
                }, true);
            }, true);
        }, true);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        SceneManager.changeScene(SceneType.COPY, 80351);
    }

    private function showPanel():void {
        if (this._isShowPanel) {
            return;
        }
        var _loc1_:Object = new Object();
        _loc1_.closeHandler = this.onSelectedPet;
        ModuleManager.toggleModule(URLUtil.getAppModule("NewPetSelectPanel"), "正在打开精灵选择面板" + "...", _loc1_);
        this._isShowPanel = true;
    }

    private function onSelectedPet():void {
        StatisticsManager.sendNovice(StatisticsManager.selectPet);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteQuest);
        QuestManager.completeStep(_quest.id, 1);
    }

    private function onStepCompleteQuest(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteQuest);
        if (param1.stepId == 1) {
            this.processStep2();
        } else if (param1.stepId == 2) {
            SceneManager.changeScene(SceneType.NOVICE, 4);
        }
    }

    private function processStep2():void {
        NpcDialog.showForNew(6, "克拉克", [[0, "嘿~新兵，我是教官克拉克，我会把你锻炼成一名优秀的赛尔！"]], "哇~这个教官好吓人！", function ():void {
            NpcDialog.showForNew(6, "克拉克", [[0, "但在此之前，我们还面临着一个问题。"]], "什么问题？", function ():void {
                NpcDialog.showForNew(6, "克拉克", [[0, "我们的飞船正在被一股强大的力量吸引到一颗神秘的星球去。"]], "啊？神秘的星球？", function ():void {
                    NpcDialog.showForNew(6, "克拉克", [[0, "是的，有许多未知的艰险正在等待着我们，你准备好了吗？"]], "是的，我准备好了！", function ():void {
                        DisplayUtil.removeForParent(_mc0);
                        StatisticsManager.newSendNovice("新手引导", "2014上半年版新手引导", "播放场景动画1");
                        _mc1_0 = _processor.resLib.getMovieClip("mc1_0");
                        _map.front.addChild(_mc1_0);
                        MovieClipUtil.playMc(_mc1_0, 2, _mc1_0.totalFrames, function ():void {
                            StatisticsManager.newSendNovice("新手引导", "2014上半年版新手引导", "成功播放场景动画1");
                            NpcDialog.showForNew(6, "克拉克", [[0, "真是不巧，" + ActorManager.actorInfo.nick + "你敢不敢和我一起去看看？"]], "当然，有什么不敢的！", function ():void {
                                DisplayUtil.removeForParent(_mc1_0);
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepCompleteQuest);
                                QuestManager.completeStep(1, 2);
                            });
                        }, true);
                    });
                });
            });
        });
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        this.hideMC0();
        DisplayUtil.removeForParent(this._mc0);
        PetAvatarPanel.recoverPanel();
    }
}
}
