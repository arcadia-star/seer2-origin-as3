package com.taomee.seer2.app.processor.quest.handler.branch.quest10140 {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10140_1070 extends QuestMapHandler {


    private var _box_mc:MovieClip;

    private var _mother_mc:MovieClip;

    private var _s_mc:MovieClip;

    private var _talk:MovieClip;

    private var _mc_0:MovieClip;

    private var _myself:Actor;

    public function QuestMapHandler_10140_1070(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.addSAgain();
            this.addMother();
            this.addBox();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.addS();
            this.addMother();
            this.addBoxAgain();
        }
    }

    private function addSAgain():void {
        this._s_mc = _processor.resLib.getMovieClip("s1");
        _map.content.addChild(this._s_mc);
        this._s_mc.buttonMode = true;
        this._s_mc.addEventListener(MouseEvent.CLICK, this.onSTalkHandler);
    }

    private function addMother():void {
        this._mother_mc = _processor.resLib.getMovieClip("ma2");
        _map.content.addChild(this._mother_mc);
    }

    private function addBox():void {
        if (this._box_mc) {
            DisplayUtil.removeForParent(this._box_mc);
        }
        this._box_mc = _processor.resLib.getMovieClip("box");
        _map.content.addChild(this._box_mc);
    }

    private function onSTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(14, "S", [[0, "这里是哪？！我在萨伦帝国这么久还没有见过这么阴森恐怖的地带！"]], ["这里好像是一个入口！前面有一扇大门！"], [function ():void {
            NpcDialog.show(14, "S", [[0, "但是大门紧闭好像是打不开的，钥匙在哪呢？"]], ["门口有一个奇怪的匣子！"], [function ():void {
                NpcDialog.show(14, "S", [[0, "嗯，我一个人过去看看就行了！"]], ["我跟你一起去吧！"], [function ():void {
                    NpcDialog.show(14, "S", [[0, "我不需要别人的帮助！这是我一个人的事情！感谢你帮助了我们进入这个地方，现在你可以和我的妈妈回去了！"]], ["只靠以一个人是不行的！"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10140_2"), function ():void {
                            addS();
                            _talk = _processor.resLib.getMovieClip("talk2");
                            LayerManager.topLayer.addChild(_talk);
                            MovieClipUtil.playMc(_talk, 1, _talk.totalFrames, function ():void {
                                NpcDialog.show(14, "S", [[0, "这个箱子好像只要碰到坚硬的东西就会爆炸，这样看来是怎么也打不开的呀"]], ["我们一起走进看看吧！"], [function ():void {
                                    NpcDialog.show(14, "S", [[0, "上面有两个手掌印还有一个项链孔。"]], ["把项链放上去，我们把手按在上面试试看吧"], [function ():void {
                                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Complete);
                                        QuestManager.completeStep(_quest.id, 2);
                                    }]);
                                }]);
                            }, true);
                        }, true, false, 2);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStep2Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        this.playBoxMC();
    }

    private function addS():void {
        if (this._s_mc) {
            DisplayUtil.removeForParent(this._s_mc);
        }
        this._s_mc = _processor.resLib.getMovieClip("s2");
        _map.content.addChild(this._s_mc);
    }

    private function addBoxAgain():void {
        if (this._box_mc) {
            DisplayUtil.removeForParent(this._box_mc);
        }
        this._box_mc = _processor.resLib.getMovieClip("box1");
        _map.content.addChild(this._box_mc);
        this._box_mc.buttonMode = true;
        this._box_mc.addEventListener(MouseEvent.CLICK, this.onOpenBoxHandler);
    }

    private function onOpenBoxHandler(param1:MouseEvent):void {
        this.playBoxMC();
    }

    private function playBoxMC():void {
        this.addBox();
        if (this._s_mc) {
            DisplayUtil.removeForParent(this._s_mc);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        this.hideMySelf();
        LayerManager.topLayer.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            littleSTalk();
        }, true);
    }

    private function hideMySelf():void {
        this._myself = ActorManager.getActor();
        this._myself.hide();
    }

    private function littleSTalk():void {
        NpcDialog.show(172, "S的记忆体", [[0, "这里是七宗炼狱的门口，里面就是七宗炼狱，炼狱底层关押着不可饶恕之人"]], ["你是谁？你怎么会在这里？"], [function ():void {
            NpcDialog.show(172, "S的记忆体", [[0, "我？我就是那个人的思念体，那个被关在这里的人，日夜想念的人就是我现在的样子"]], ["你是S爸爸思念幻化出的？"], [function ():void {
                NpcDialog.show(172, "S的记忆体", [[0, "你若想和S拯救关押在牢底的那个人，就请通过这严酷的七宗炼狱吧。"]], ["七宗炼狱？"], [function ():void {
                    NpcDialog.show(172, "S的记忆体", [[0, "这里就是七种不同原罪炼狱，关在这里的全部都是凶神恶煞。在炼狱的底层关押着萨伦最不能饶恕的那个人和他的无畏精灵。"]], ["是什么精灵？"], [function ():void {
                        NpcDialog.show(172, "S的记忆体", [[0, "是那个人曾经使用的精灵。能够在这样的炼狱中生存，应该比从前更加强大了吧！"]], ["我们怎么前往那里？"], [function ():void {
                            NpcDialog.show(172, "S的记忆体", [[0, "既然你们打开了这个灵魂之匣，我将注定成为你们前进的指引，只是…弱者将会如尘迹般葬身于此。希望你们做好了这次旅行的准备。"]], ["好的，新的冒险就要开始了！"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.COMPLETE, onStep3Complete);
                                QuestManager.completeStep(_quest.id, 3);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStep3Complete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep3Complete);
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mother_mc) {
            DisplayUtil.removeForParent(this._mother_mc);
        }
        this._myself.show();
    }

    override public function processMapDispose():void {
        if (this._mother_mc) {
            DisplayUtil.removeForParent(this._mother_mc);
        }
        if (this._s_mc) {
            DisplayUtil.removeForParent(this._s_mc);
        }
        if (this._box_mc) {
            DisplayUtil.removeForParent(this._box_mc);
        }
        if (this._talk) {
            DisplayUtil.removeForParent(this._talk);
        }
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Complete);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStep3Complete);
    }
}
}
