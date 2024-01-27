package com.taomee.seer2.app.processor.quest.handler.story.quest59 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.map.MapProcessor_950;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class QuestMapHandler_59_950 extends QuestMapHandler {


    private var badi:MovieClip;

    private var paper:MovieClip;

    private var closePaper:SimpleButton;

    private var paperDetail:MovieClip;

    private var mark:AcceptableMark;

    public function QuestMapHandler_59_950(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        ActorManager.getActor().removeEventListener(MoveEvent.FINISHED, this.checkDis);
        if (this.paper) {
            this.paper.removeEventListener(MouseEvent.CLICK, this.clickPaper);
        }
        if (this.closePaper) {
            this.closePaper.addEventListener(MouseEvent.CLICK, this.showDia);
        }
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isComplete(_quest.id)) {
            this.initStep3();
        }
    }

    private function initStep3():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("59_2"), function ():void {
            badi = _processor.resLib.getMovieClip("Quest59_Npc_Badi");
            paper = _processor.resLib.getMovieClip("Quest59_MC_Paper");
            paper.x = 400;
            paper.y = 220;
            badi.x = 810;
            badi.y = 430;
            mark = new AcceptableMark();
            mark.x = 400;
            mark.y = 200;
            _map.content.addChild(mark);
            _map.content.addChild(badi);
            _map.content.addChild(paper);
            paper.buttonMode = true;
            paper.addEventListener(MouseEvent.CLICK, clickPaper);
        });
    }

    private function clickPaper(param1:MouseEvent):void {
        var _loc2_:MapProcessor_950 = SceneManager.active.mapModel.mapProcessor as MapProcessor_950;
        if (_loc2_.isCrack) {
            ActorManager.getActor().addEventListener(MoveEvent.FINISHED, this.checkDis);
            ActorManager.getActor().walk(this.paper.x, this.paper.y);
        } else {
            AlertManager.showAlert("这里一定有什么机关才可以上去捡到信纸，看到上面的内容。仔细找找吧~");
        }
    }

    private function checkDis(param1:MoveEvent):void {
        var _loc2_:int = this.paper.x - ActorManager.getActor().x;
        var _loc3_:int = this.paper.y - ActorManager.getActor().y;
        var _loc4_:int;
        if ((_loc4_ = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_)) < 100) {
            ActorManager.getActor().removeEventListener(MoveEvent.FINISHED, this.checkDis);
            this.paperDetail = _processor.resLib.getMovieClip("Quest59_MC_PaperDetail");
            this.paperDetail.x = 300;
            this.paperDetail.y = 40;
            _map.front.addChild(this.paperDetail);
            this.closePaper = this.paperDetail["closeBtn"];
            this.closePaper.addEventListener(MouseEvent.CLICK, this.showDia);
            DisplayObjectUtil.removeFromParent(this.mark);
        }
    }

    private function showDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayObjectUtil.removeFromParent(this.paperDetail);
        DisplayObjectUtil.removeFromParent(this.paper);
        this.closePaper.removeEventListener(MouseEvent.CLICK, this.showDia);
        this.badi.x = 360;
        this.badi.y = 235;
        NpcDialog.show(400, "我", [[0, "席德边上的人怎么看着这么眼熟，难道是……"]], [], [function ():void {
            NpcDialog.show(10, "巴蒂", [[0, "是什么你见过的人吗？"]], [], [function ():void {
                NpcDialog.show(400, "我", [[0, "对！他看起来就像上次袭击我的暗杀者！可是席德怎么会跟他在一起呢？"]], [], [function ():void {
                    NpcDialog.show(10, "巴蒂", [[0, "这还不简单！他们明显是一伙的！都不是好东西！"]], [], [function ():void {
                        var npcNode:*;
                        var npc:*;
                        ActorManager.getActor().hide();
                        npcNode = <npc id="106" resId="106" name="席斯坦因" dir="1" width="25" height="90" pos="480,195"
                                       actorPos="821,288" path=""/>;
                        npc = MobileManager.createNpc(new NpcDefinition(npcNode));
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("59_3"), function ():void {
                            DisplayObjectUtil.removeFromParent(badi);
                            NpcDialog.show(106, "斯坦因", [[1, "这个隧道会把你们传送到你们该去的地方！桀桀桀！奥罗吉尔！给我滚出来！"]], [], [function ():void {
                                var pet:* = undefined;
                                pet = _processor.resLib.getMovieClip("AoLuoJier");
                                _map.content.addChild(pet);
                                NpcDialog.show(519, "奥罗吉尔", [[0, "主人……"]], [], [function ():void {
                                    NpcDialog.show(106, "斯坦因", [[1, "让你看个门都干不好！真是废物！"]], [], [function ():void {
                                        NpcDialog.show(519, "奥罗吉尔", [[0, "主人……他们太强了……"]], [], [function ():void {
                                            NpcDialog.show(106, "斯坦因", [[1, "嗯，看来赛尔们已经有了很大程度的成长！桀桀桀！你！以后就多叫几个弟兄，在御风广场给我看好门吧！桀桀桀！"]], [], [function ():void {
                                                NpcDialog.show(519, "奥罗吉尔", [[0, "呜呜呜……好吧主人……虽然伦家最不喜欢抛头露面了……"]], [], [function ():void {
                                                    NpcDialog.show(106, "斯坦因", [[1, "少废话！看来新的时代就要来临了！桀桀桀！桀桀桀！"]], [], [function ():void {
                                                        DisplayObjectUtil.removeFromParent(pet);
                                                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
                                                        QuestManager.completeStep(_quest.id, 3);
                                                    }]);
                                                }]);
                                            }]);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        });
                    }]);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 59 && param1.stepId == 3) {
            SceneManager.changeScene(SceneType.LOBBY, 930);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        }
    }
}
}
