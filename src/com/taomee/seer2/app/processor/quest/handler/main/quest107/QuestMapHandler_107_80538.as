package com.taomee.seer2.app.processor.quest.handler.main.quest107 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_107_80538 extends QuestMapHandler {


    public function QuestMapHandler_107_80538(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (!QuestManager.isAccepted(_quest.id)) {
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) == true) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        var dialog:Array;
        var npc:MovieClip = null;
        npc = _processor.resLib.getMovieClip("duoLuo");
        npc.x += 310;
        npc.y += 135;
        SceneManager.active.mapModel.front.addChild(npc);
        npc.buttonMode = true;
        npc.mouseChildren = false;
        dialog = [[93, "刚铎", [[0, "嘿！星际使者！你们俩刚才急匆匆的离开，又找到了什么吗？"]], ["......"]], [11, "多罗", [[0, "怪大叔让我的女神先走了！我只好跟着他在这等你们……"]], ["看来你更喜欢“女神”一点？"]], [11, "多罗", [[0, "队长我没这个意思！亮晶晶，亮晶晶小队永远是我们共同的家！"]], ["这还差不多嘛。"]], [400, "小赛尔", [[0, "刚铎先生，我想我们应该去冒昧地打扰一下约瑟王了。"]], ["..........."]], [93, "刚铎", [[0, "北方的精灵王约瑟，他是个值得被崇敬的存在。如果是为了丢失的真相，他会伸出援手吧。作为我们北方的信仰……我也不再多说了，为了真相，那就去吧。"]], ["谢谢刚铎先生。"]], [400, "小赛尔", [[0, "那么我宣布，第七小队的下一个目的地，王者遗迹！"]], ["......"]]];
        NpcDialog.showDialogs(dialog, function ():void {
            QuestManager.completeStep(_quest.id, 2);
            SceneManager.changeScene(SceneType.LOBBY, 70);
        });
    }
}
}
