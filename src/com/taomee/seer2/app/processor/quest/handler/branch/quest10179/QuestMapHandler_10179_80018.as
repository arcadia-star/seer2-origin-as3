package com.taomee.seer2.app.processor.quest.handler.branch.quest10179 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10179_80018 extends QuestMapHandler {


    private var _npc:MovieClip;

    private var _npc1:MovieClip;

    private var _npc2:MovieClip;

    private var _npc3:MovieClip;

    private const POS:Array = [[233, 323], [439, 300], [315, 380]];

    public function QuestMapHandler_10179_80018(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.handle1();
        } else if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.handle1();
        } else if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.handle2();
        }
    }

    private function handle1():void {
        this._npc = _processor.resLib.getMovieClip("npc");
        this._npc.x = 328;
        this._npc.y = 266;
        this._npc["mark"].visible = true;
        _map.content.addChild(this._npc);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
    }

    private function onNpcClick(param1:MouseEvent):void {
        var sceneMc:MovieClip = null;
        var evt:MouseEvent = param1;
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        DisplayUtil.removeForParent(this._npc);
        QuestManager.accept(_quest.id);
        sceneMc = _processor.resLib.getMovieClip("scene_1");
        _map.front.addChild(sceneMc);
        MovieClipUtil.playMc(sceneMc, 2, sceneMc.totalFrames, function ():void {
            DisplayUtil.removeForParent(sceneMc);
            _npc1 = _processor.resLib.getMovieClip("npc_1");
            _npc1.x = POS[0][0];
            _npc1.y = POS[0][1];
            _npc1["mark"].visible = true;
            _map.content.addChild(_npc1);
            _npc1.buttonMode = true;
            sceneMc = _processor.resLib.getMovieClip("sceneTalk_1");
            _map.front.addChild(sceneMc);
            MovieClipUtil.playMc(sceneMc, 2, sceneMc.totalFrames, function ():void {
                DisplayUtil.removeForParent(sceneMc);
                sceneMc = null;
                _npc1.addEventListener(MouseEvent.CLICK, onNpc1Click);
            }, true);
        }, true);
    }

    private function onNpc1Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(32, "小兵甲", [[1, "你！干什么的？！"]], ["我是赛尔！"], [function ():void {
            NpcDialog.show(400, "小赛尔", [[3, "原来H7N9是你们这帮混蛋干的！你们不能杀害鸟类，它们是我们的朋友！"]], ["算你聪明！"], [function ():void {
                NpcDialog.show(32, "小兵乙", [[0, "算你聪明，我警告你铁皮罐子，最好滚回你的飞船去，H7N9禽流感不是闹着玩的！睁开眼看看吧!"]], ["你们到底做了什么？"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10179_1"), function ():void {
                        DisplayUtil.removeForParent(_npc1);
                        _npc1.removeEventListener(MouseEvent.CLICK, onNpc1Click);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepOneComplete);
                        QuestManager.completeStep(_quest.id, 1);
                    }, true, true, 2);
                }]);
            }]);
        }]);
    }

    private function onStepOneComplete(param1:QuestEvent):void {
        this.handle2();
    }

    private function handle2():void {
        this._npc2 = _processor.resLib.getMovieClip("npc_2");
        this._npc2.x = this.POS[1][0];
        this._npc2.y = this.POS[1][1];
        this._npc2["mark"].visible = true;
        _map.content.addChild(this._npc2);
        this._npc3 = _processor.resLib.getMovieClip("npc_3");
        this._npc3.x = this.POS[2][0];
        this._npc3.y = this.POS[2][1];
        this._npc3["mark"].visible = false;
        _map.content.addChild(this._npc3);
        this._npc2.buttonMode = true;
        this._npc2.addEventListener(MouseEvent.CLICK, this.onNpc2Click);
    }

    private function onNpc2Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(526, "孔雀", [[2, "小赛尔，怎么办？它受伤了！是它救了我！你能救救它吗？"]], ["别难过，我一定会帮你"], [function ():void {
            NpcDialog.show(400, "赛尔", [[0, "它中了箭伤，我去找些急救物品帮它清理下伤口！"]], ["去找急救品"], [function ():void {
                ModuleManager.showModule(URLUtil.getAppModule("FindGoodPanel"), "正在打开找你妹交互...", {"func": afterGameHandle});
            }]);
        }]);
    }

    private function afterGameHandle():void {
        this._npc2["mark"].visible = false;
        this._npc2.buttonMode = false;
        this._npc3["mark"].visible = true;
        this._npc3.buttonMode = true;
        this._npc2.removeEventListener(MouseEvent.CLICK, this.onNpc2Click);
        this._npc3.addEventListener(MouseEvent.CLICK, this.onNpc3Click);
    }

    private function onNpc3Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._npc3.removeEventListener(MouseEvent.CLICK, this.onNpc3Click);
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10179_2"), function ():void {
            NpcDialog.show(565, "渡鸦之首", [[1, "我是渡鸦之首，谢谢你们救了我——"]], ["快别这么说"], [function ():void {
                NpcDialog.show(526, " 孔雀", [[1, "你才是我的救命恩人！救你的是小赛尔哦!"]], ["小赛尔快过来"], [function ():void {
                    NpcDialog.show(400, "小赛尔", [[1, "小意思啦！嘿嘿！你们大家都没事我就放心了。"]], ["接下去要做啥？（聊天陷入尴尬中）"], [function ():void {
                        NpcDialog.show(526, "孔雀", [[1, "渡鸦之首，小赛尔，你们都是我的救命恩人，我一定要带你们去见月神！今天是月神现身之日，我想其它的鸟都已经到了！"]], ["好！那我们走吧！"], [function ():void {
                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10179_3"), function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepTwoComplete);
                                QuestManager.completeStep(_quest.id, 2);
                            }, true, true, 2);
                        }]);
                    }]);
                }]);
            }]);
        }, true, true, 2);
    }

    private function onStepTwoComplete(param1:QuestEvent):void {
        SceneManager.changeScene(SceneType.COPY, 80017);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
        }
        if (this._npc1) {
            this._npc1.removeEventListener(MouseEvent.CLICK, this.onNpc1Click);
            DisplayUtil.removeForParent(this._npc1);
        }
        if (this._npc2) {
            this._npc2.removeEventListener(MouseEvent.CLICK, this.onNpc2Click);
            DisplayUtil.removeForParent(this._npc2);
        }
        if (this._npc3) {
            this._npc3.removeEventListener(MouseEvent.CLICK, this.onNpc3Click);
            DisplayUtil.removeForParent(this._npc3);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoComplete);
    }
}
}
