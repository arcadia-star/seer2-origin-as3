package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_80152 extends MapProcessor
   {
      
      private static const fight_index:Array = [831,832,833,834,835,836];
       
      
      private const npcId:int = 708;
      
      private var _npc:Mobile;
      
      private var haveFightCount:int;
      
      private var buyFightCount:int;
      
      private var leftFightCount:int;
      
      private var fightStatus:int;
      
      public function MapProcessor_80152(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               ModuleManager.showModule(URLUtil.getAppModule("HuoMoYanSaWinPanel"),"");
            }
            else
            {
               ModuleManager.showModule(URLUtil.getAppModule("HuoMoYanSaLosePanel"),"");
            }
         }
         this.initNpc();
      }
      
      private function initNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(460,275));
            this._npc.resourceUrl = URLUtil.getNpcSwf(this.npcId);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "炎煞";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      protected function onNpcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         DayLimitManager.getDoCount(1010,function(param1:uint):void
         {
            var count:uint = param1;
            haveFightCount = count;
            ActiveCountManager.requestActiveCountList([203809,203814],function(param1:Parser_1142):void
            {
               var pre:Parser_1142 = param1;
               buyFightCount = pre.infoVec[0];
               fightStatus = pre.infoVec[1];
               if(haveFightCount > 1)
               {
                  leftFightCount = buyFightCount;
               }
               else
               {
                  leftFightCount = buyFightCount + 1 - haveFightCount;
               }
               if(fightStatus == 6)
               {
                  AlertManager.showAlert("你已经可以去领取了炎煞了");
               }
               else if(leftFightCount > 0)
               {
                  NpcDialog.show(npcId,"炎煞",[[0,"400年了！这里除了多了几个铁皮人变化貌似也不大，和我火魔过过招吧！"]],["挑战来吧","你和凯萨好像啊"],[function():void
                  {
                     FightManager.startFightWithWild(fight_index[fightStatus]);
                  }]);
               }
               else
               {
                  ModuleManager.showModule(URLUtil.getAppModule("HuoMoYanSaSalePanel"),"",{"fightIndex":fightStatus});
               }
            });
         });
      }
   }
}
