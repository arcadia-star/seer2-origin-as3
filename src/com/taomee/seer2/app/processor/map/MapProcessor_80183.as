package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80183 extends MapProcessor
   {
      
      private static const FIGHT_INDEX:int = 944;
      
      private static const FIGHT_NUM_DAY:int = 204081;
      
      private static const FIGHT_NUM_MI_BUY_FOR:int = 204085;
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1,2]);
       
      
      private var _npc:Mobile;
      
      public function MapProcessor_80183(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.zhouSiActInit();
      }
      
      private function addOpenVip() : void
      {
         (_map.front["openVipBtn"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onOpenVip);
      }
      
      private function onOpenVip(param1:MouseEvent) : void
      {
         VipManager.openVip();
      }
      
      private function zhouSiActInit() : void
      {
         this.addOpenVip();
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
         {
            ActiveCountManager.requestActiveCountList([FIGHT_NUM_DAY,FIGHT_NUM_MI_BUY_FOR],function(param1:Parser_1142):void
            {
               var canFightNum:int = 0;
               var par:Parser_1142 = param1;
               if(VipManager.vipInfo.isVip())
               {
                  if(par.infoVec[0] > FIGHT_NUM_RULE[1])
                  {
                     canFightNum = int(par.infoVec[1]);
                  }
                  else
                  {
                     canFightNum = FIGHT_NUM_RULE[1] - par.infoVec[0] + par.infoVec[1];
                  }
               }
               else if(par.infoVec[0] > FIGHT_NUM_RULE[0])
               {
                  canFightNum = int(par.infoVec[1]);
               }
               else
               {
                  canFightNum = FIGHT_NUM_RULE[0] - par.infoVec[0] + par.infoVec[1];
               }
               if(canFightNum > 0)
               {
                  createNpc();
               }
               else
               {
                  TweenNano.delayedCall(3,function():void
                  {
                     ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                     SceneManager.changeScene(SceneType.LOBBY,70);
                  });
               }
            });
         }
         else
         {
            this.createNpc();
         }
      }
      
      private function moPKshenActDispose() : void
      {
         this.clearNpc();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 140;
            this._npc.setPostion(new Point(480,320));
            this._npc.resourceUrl = URLUtil.getNpcSwf(738);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "雅典娜";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(738,"雅典娜",[[0,"智慧之光是我雅典娜的赠予！"]],["开始挑战","准备一下"],[function():void
         {
            FightManager.startFightWithWild(FIGHT_INDEX);
         }]);
      }
      
      private function clearNpc() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
         }
      }
      
      override public function dispose() : void
      {
         this.moPKshenActDispose();
         super.dispose();
      }
   }
}
