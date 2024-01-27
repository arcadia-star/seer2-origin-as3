package com.taomee.seer2.app.processor.quest.handler.story.quest55 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_55_880 extends QuestMapHandler {

    public static const CURRENT_QUEST_ID:int = 55;


    private var _fuzzyPeopleMc:MovieClip;

    private var _badEggsMc:MovieClip;

    private var _fightBeginMovie:MovieClip;

    public function QuestMapHandler_55_880(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id)) {
            if (!QuestManager.isStepComplete(_quest.id, 1)) {
                if (CURRENT_QUEST_ID == _quest.id) {
                    this.appearFuzzyPeople();
                }
            } else if (!QuestManager.isStepComplete(_quest.id, 2)) {
                if (SceneType.ARENA == SceneManager.prevSceneType) {
                    this.playStaticMovie();
                } else if (SceneManager.prevMapID == 880) {
                    this.recoverScene();
                } else {
                    this.onStep1Complete();
                }
            } else if (!QuestManager.isStepComplete(_quest.id, 3)) {
                this.onStep2Complete();
            }
        }
    }

    private function recoverScene():void {
        FightManager.startFightWithNPC(28);
    }

    private function appearFuzzyPeople():void {
        var mc:MovieClip = _processor.resLib.getMovieClip("FuzzyPeople");
        this._fuzzyPeopleMc = mc;
        LayerManager.topLayer.addChild(mc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            LayerManager.resetOperation();
            playTalk_1();
        });
    }

    private function playSceneMovie(param1:String, param2:Function = null):void {
        var mc:MovieClip = null;
        var sceneMovieName:String = param1;
        var callBackFun:Function = param2;
        mc = _processor.resLib.getMovieClip(sceneMovieName);
        LayerManager.topLayer.addChild(mc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            LayerManager.resetOperation();
            LayerManager.topLayer.removeChild(mc);
            if (callBackFun != null && callBackFun is Function) {
                callBackFun();
            }
        });
    }

    private function playTalk_1():void {
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "这，这里是什么地方？还有这巨大的影像...！！"]], ["璞玉，你到底要告诉我什么？"], [function ():void {
            NpcDialog.show(131, "模糊的影像", [[0, "这里，名为能源之潮......"]], ["哇！那个巨大的东西说话了！！"], [function ():void {
                NpcDialog.show(131, "模糊的影像", [[0, "那一场战役结束之后，星球被撕裂，而我们也变成了四散的精元。我将最后的意愿保留在这里..."]], ["是的"], [function ():void {
                    NpcDialog.show(131, "模糊的影像", [[0, "当有一位能够谱写星球崭新未来的使者，通过重重考验获得六块璞玉的时候，我会将星球的未来托付给他..."]], ["等等，你，你难道是...！！！"], [function ():void {
                        playFullScreenMovie();
                    }]);
                }]);
            }]);
        }]);
    }

    private function playFullScreenMovie():void {
        MovieClipUtil.playFullScreen("res/active/fullScreen/55.swf", function ():void {
            playTalk_2();
        }, true, true);
    }

    private function playTalk_2():void {
        NpcDialog.show(131, "模糊的影像", [[0, "博学，羁绊，奋战，合作，坚强，自由……经历了这一切的你，还需要最后的一件东西。"]], ["这都是在七大氏族所学到的，最后一样东西是什么？"], [function ():void {
            var mc:* = undefined;
            mc = _processor.resLib.getMovieClip("HopeMovie");
            LayerManager.topLayer.addChild(mc);
            LayerManager.focusOnTopLayer();
            MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                LayerManager.resetOperation();
                LayerManager.topLayer.removeChild(mc);
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "唤醒了七大守护兽，是否意味着……精灵王就能复活呢？而这片温暖的光芒是什么？难道就是……灵魂？"]], ["刚才的那个影像，是精灵王吗？"], [function ():void {
                    mc = _processor.resLib.getMovieClip("BadEggEntrance");
                    _badEggsMc = mc;
                    LayerManager.topLayer.addChild(mc);
                    LayerManager.focusOnTopLayer();
                    MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                        LayerManager.resetOperation();
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Complete);
                        QuestManager.completeStep(_quest.id, 1);
                    });
                }]);
            });
        }]);
    }

    private function onStep1Complete(param1:QuestEvent = null):void {
        var _loc2_:MovieClip = null;
        if (this._fuzzyPeopleMc == null) {
            _loc2_ = _processor.resLib.getMovieClip("FuzzyPeople");
            this._fuzzyPeopleMc = _loc2_;
            LayerManager.topLayer.addChild(_loc2_);
            this._fuzzyPeopleMc.gotoAndStop(this._fuzzyPeopleMc.totalFrames);
        }
        if (this._badEggsMc == null) {
            _loc2_ = _processor.resLib.getMovieClip("BadEggEntrance");
            this._badEggsMc = _loc2_;
            LayerManager.topLayer.addChild(_loc2_);
            this._badEggsMc.gotoAndStop(this._badEggsMc.totalFrames);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Complete);
        _processor.showMouseHintAt(540, 130);
        this._badEggsMc.addEventListener(MouseEvent.CLICK, this.playSceneMovie2);
    }

    private function playSceneMovie2(param1:MouseEvent):void {
        var mc:MovieClip;
        var event:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._badEggsMc.removeEventListener(MouseEvent.CLICK, this.playSceneMovie2);
        mc = _processor.resLib.getMovieClip("FightBeginMovie");
        this._fightBeginMovie = mc;
        LayerManager.topLayer.addChild(mc);
        LayerManager.focusOnTopLayer();
        this._badEggsMc.visible = false;
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            _fuzzyPeopleMc.visible = false;
            _fightBeginMovie.visible = false;
            LayerManager.resetOperation();
            FightManager.startFightWithNPC(28);
        });
    }

    private function playStaticMovie():void {
        if (this._fightBeginMovie) {
            this._fightBeginMovie.visible = true;
            this._fuzzyPeopleMc.visible = true;
        }
        MovieClipUtil.playFullScreen("res/active/fullScreen/55_1.swf", function ():void {
            playFullScreenMovieAfterFight();
        });
    }

    private function playFullScreenMovieAfterFight():void {
        var mc:MovieClip = null;
        if (this._fuzzyPeopleMc == null) {
            mc = _processor.resLib.getMovieClip("FuzzyPeople");
            this._fuzzyPeopleMc = mc;
            LayerManager.topLayer.addChild(mc);
            this._fuzzyPeopleMc.gotoAndStop(this._fuzzyPeopleMc.totalFrames);
        }
        if (this._badEggsMc == null) {
            mc = _processor.resLib.getMovieClip("BadEggEntrance");
            this._badEggsMc = mc;
            LayerManager.topLayer.addChild(mc);
            this._badEggsMc.gotoAndStop(this._badEggsMc.totalFrames);
        }
        LayerManager.focusOnTopLayer();
        NpcDialog.show(499, "炎帝", [[0, "有趣……有趣……！！敢问阁下大名？我答应你，斩杀你之后，我会记得你的名字！！"]], ["斩杀雷伊？你别想了！！"], [function ():void {
            NpcDialog.show(477, "雷伊", [[0, "好好记住战胜你的人的名字：雷伊！！可惜，像你这样强大的精灵，居然会站在邪恶势力这一边..."]], ["（我突然想起了某个背影...难道...）"], [function ():void {
                LayerManager.resetOperation();
                DisplayUtil.removeForParent(_fightBeginMovie);
                _badEggsMc.visible = true;
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Complete);
                QuestManager.completeStep(_quest.id, 2);
            }]);
        }]);
    }

    private function onStep2Complete(param1:QuestEvent = null):void {
        var _loc2_:MovieClip = null;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        if (this._fuzzyPeopleMc == null) {
            _loc2_ = _processor.resLib.getMovieClip("FuzzyPeople");
            this._fuzzyPeopleMc = _loc2_;
            LayerManager.topLayer.addChild(_loc2_);
            this._fuzzyPeopleMc.gotoAndStop(this._fuzzyPeopleMc.totalFrames);
        }
        if (this._badEggsMc == null) {
            _loc2_ = _processor.resLib.getMovieClip("BadEggEntrance");
            this._badEggsMc = _loc2_;
            LayerManager.topLayer.addChild(_loc2_);
            this._badEggsMc.gotoAndStop(this._badEggsMc.totalFrames);
        }
        LayerManager.focusOnTopLayer();
        this._badEggsMc.addEventListener(MouseEvent.CLICK, this.playEndTalk);
        _processor.showMouseHintAt(540, 130);
    }

    private function playEndTalk(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        LayerManager.resetOperation();
        _processor.hideMouseClickHint();
        this._badEggsMc.removeEventListener(MouseEvent.CLICK, this.playEndTalk);
        NpcDialog.show(39, "缇娜", [[0, "还啰嗦什么？啧——看来不让它来不行。"]], ["来什么都不怕！"], [function ():void {
            _badEggsMc.visible = false;
            playSceneMovie("FightMovie", function ():void {
                _badEggsMc.visible = true;
                DisplayUtil.removeForParent(_fuzzyPeopleMc);
                DisplayUtil.removeForParent(_badEggsMc);
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "什么？那道光芒是复活精灵王的关键？！？！"]], ["居然被萨伦帝国抢走了！！"], [function ():void {
                    NpcDialog.show(477, "雷伊", [[0, "我一定会剿灭邪恶势力，夺回星球的“希望”！！"]], ["看来……下半星球之旅，势在必行！！"], [function ():void {
                        NpcDialog.show(499, "炎帝", [[0, "你们——试试看。"]], ["不管你是谁——都休想阻挠我们！！"], [function ():void {
                            playSceneMovie("RollTitles", function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep3Complete);
                                QuestManager.completeStep(_quest.id, 3);
                            });
                        }]);
                    }]);
                }]);
            });
        }]);
    }

    private function onStep3Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep3Complete);
        SceneManager.changeScene(SceneType.LOBBY, 850);
    }
}
}
