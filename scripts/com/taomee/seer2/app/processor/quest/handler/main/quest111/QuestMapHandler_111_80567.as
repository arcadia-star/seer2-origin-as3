package com.taomee.seer2.app.processor.quest.handler.main.quest111
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.constant.PetType;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_111_80567 extends QuestMapHandler
   {
       
      
      private var _npcTalkContainer:MovieClip;
      
      private var _npcTalkContentIndex:int;
      
      private var _npcTalkContent:MovieClip;
      
      private var _npcTalkBtnIndex:int;
      
      private var _curPos:int = 1;
      
      public function QuestMapHandler_111_80567(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         SceneManager.active.mapModel.content["mv"].visible = false;
         SceneManager.active.mapModel.content["badi"].addEventListener(MouseEvent.CLICK,this.onBadiClick);
         this.initStep1();
      }
      
      private function initStep1() : void
      {
         this.onBadiClick(null);
      }
      
      private function onBadiClick(param1:* = null) : void
      {
         var dialog0:Array = null;
         var e:* = param1;
         var type:int = ActorManager.actorInfo.followingPetInfo == null ? 0 : ActorManager.actorInfo.followingPetInfo.type;
         if(ActorManager.actorInfo.followingPetInfo.type == PetType.ELECTRIC)
         {
            this.initStep1_1();
         }
         else
         {
            dialog0 = [[10,"巴蒂",[[0,"那么，先请出耀眼的电系精灵吧！"]],["让一只电系精灵跟随吧。"]]];
            NpcDialog.showDialogs(dialog0,function():void
            {
            });
         }
      }
      
      private function initStep1_1() : void
      {
         var dialog1:Array = null;
         var mv:MovieClip = null;
         var dialog0:Array = [[10,"巴蒂",[[0,"好了，队长。现在该雷电结晶出场了！"]],["巴蒂看起来很兴奋啊。"]]];
         dialog1 = [[400,"小赛尔",[[0,"终于开机了。但是这文字……“现有计算设备已超负荷，数据无法完全处理”？"]],["……"]],[10,"巴蒂",[[0,"果然不出我所料。数据不完善是因为设施自带的计算性能太差，处理不完这些数据！"]],["那么，我们就需要更高效的计算设备了。"]],[11,"多罗",[[0,"开机了，但是还是用不成……"]],["没关系，我们已经很接近那个结果了！"]],[10,"巴蒂",[[0,"队长你放心，只要申请到资料室那台大型量子计算机的使用权限，一切就迎刃而解了！"]],["那么，准备好通讯，我亲自向娜威拉申请！"]]];
         mv = SceneManager.active.mapModel.content["mv"];
         mv.visible = true;
         NpcDialog.showDialogs(dialog0,function():void
         {
            MovieClipUtil.playMc(mv,2,mv.totalFrames,function():void
            {
               mv.visible = false;
               NpcDialog.showDialogs(dialog1,function():void
               {
                  QuestManager.completeStep(_quest.id,1);
                  SceneManager.changeScene(SceneType.COPY,80574);
               });
            });
         });
      }
   }
}
