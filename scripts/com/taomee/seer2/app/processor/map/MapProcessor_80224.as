package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MapProcessor_80224 extends MapProcessor
   {
       
      
      private const HURT_VALUE_ID:uint = 204418;
      
      private const BUY_FIGHT_COUNT:uint = 204419;
      
      private const FIGHT_COUNT_ID:uint = 1232;
      
      private const FIGHT_INDEX:uint = 1098;
      
      private const FREE_COUNT:uint = 3;
      
      private const NEED_HURT:uint = 3000000;
      
      private const MAX_HEIGHT:uint = 274;
      
      private const BAONU_MAP:uint = 80225;
      
      private const BUY_PASS_ID:uint = 603948;
      
      private const BUY_COUNT_ID:uint = 603947;
      
      private var hasPlayScene1:Boolean;
      
      private var allHurtValue:uint;
      
      private var buyCount:uint;
      
      private var leftCount:uint;
      
      private var npc:MovieClip;
      
      private var hurtBar:MovieClip;
      
      private var hurtTxt:TextField;
      
      private var leftCountTxt:TextField;
      
      private var exitBtn:SimpleButton;
      
      private var isToFight:Boolean;
      
      public function MapProcessor_80224(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.npc = _map.content["eyePet"];
         this.hurtTxt = _map.front["allHurtTxt"];
         this.leftCountTxt = _map.front["leftCountTxt"];
         this.hurtBar = _map.front["hurtBar"];
         this.exitBtn = _map.front["exitBtn"];
         this.npc.mouseChildren = false;
         this.npc.buttonMode = true;
         this.npc.addEventListener(MouseEvent.CLICK,this.onNpc);
         this.exitBtn.addEventListener(MouseEvent.CLICK,this.toExit);
         ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_211,this.getBuffer);
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      protected function toExit(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.npc.removeEventListener(MouseEvent.CLICK,this.onNpc);
         this.exitBtn.removeEventListener(MouseEvent.CLICK,this.toExit);
         if(!this.isToFight)
         {
            (SceneManager.active as LobbyScene).showToolbar();
         }
         this.isToFight = false;
      }
      
      protected function onNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(113,"超级nono ",[[0,"即将开始与目灵神的挑战，今天还剩余" + this.leftCount + "次挑战机会，每次最多造成目灵神25万伤害。"]],["开始挑战 ","准备一下"],[function():void
         {
            toFight();
         }]);
      }
      
      private function toFight() : void
      {
         if(this.leftCount == 0)
         {
            NpcDialog.show(113,"超级nono",[[0,"今天的挑战次数已经用尽，是否花费星钻立即挑战？"]],["开始挑战","准备一下"],[function():void
            {
               ShopManager.buyItemForId(BUY_COUNT_ID,onCount);
            }]);
            return;
         }
         this.isToFight = true;
         FightManager.startFightWithBoss(this.FIGHT_INDEX);
      }
      
      private function onCount(param1:*) : void
      {
         this.isToFight = true;
         FightManager.startFightWithBoss(this.FIGHT_INDEX);
      }
      
      private function getBuffer(param1:ServerBuffer) : void
      {
         this.hasPlayScene1 = Boolean(param1.readDataAtPostion(16));
         ActiveCountManager.requestActiveCountList([this.HURT_VALUE_ID,this.BUY_FIGHT_COUNT],this.getData);
      }
      
      private function getData(param1:Parser_1142) : void
      {
         this.allHurtValue = param1.infoVec[0];
         this.buyCount = param1.infoVec[1];
         DayLimitManager.getDoCount(this.FIGHT_COUNT_ID,this.getDayData);
      }
      
      private function getDayData(param1:uint) : void
      {
         this.leftCount = this.getCanNum(param1,this.buyCount,this.FREE_COUNT);
         this.hurtTxt.text = this.allHurtValue.toString();
         this.leftCountTxt.text = this.leftCount.toString();
         this.hurtBar.height = this.allHurtValue / this.NEED_HURT * this.MAX_HEIGHT;
         if(!this.hasPlayScene1)
         {
            this.npc.visible = false;
            ActorManager.getActor().visible = false;
            ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_211,16,1);
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("EyeSuperEvolveFull1"),this.showDia,false,false,1,false);
         }
         else if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            this.showFightResult();
         }
      }
      
      private function showFightResult() : void
      {
         var left:uint = this.allHurtValue < this.NEED_HURT ? uint(this.NEED_HURT - this.allHurtValue) : 0;
         if(left == 0)
         {
            this.onPass(null);
            return;
         }
         NpcDialog.show(113,"超级nono",[[0,"距离300万伤害还差" + left + "，请再接再厉！超级目灵兽等着你哦~"]],["确定","一键通关"],[null,function():void
         {
            ShopManager.buyItemForId(BUY_PASS_ID,onPass);
         }]);
      }
      
      private function onPass(param1:*) : void
      {
         var p:* = param1;
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("EyeSuperEvolveFull2"),function():void
         {
            SceneManager.changeScene(SceneType.COPY,BAONU_MAP);
         });
      }
      
      public function getCanNum(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(param1 > param3)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = param3 - param1 + param2;
         }
         return _loc4_;
      }
      
      private function showDia() : void
      {
         this.npc.visible = true;
         ActorManager.getActor().visible = true;
         NpcDialog.show(113,"超级nono",[[0,"这是哪里？好像与目灵祭坛有些不一样。"]],[" 连目灵神都好像不同了"],[function():void
         {
            NpcDialog.show(113,"超级nono",[[0,"这里是目灵神的梦境世界哦~"]],[" 梦境世界？"],[function():void
            {
               NpcDialog.show(113,"超级nono",[[0,"看来只有打败梦境世界这只奇怪的目灵神才能唤醒真正的目灵神了。"]],["交给我吧！"],[function():void
               {
               }]);
            }]);
         }]);
      }
   }
}
