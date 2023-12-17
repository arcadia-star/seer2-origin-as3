package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.vip.VipManager;
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
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcessor_80330 extends MapProcessor
   {
      
      private static const DAY_LIST:Array = [1407];
      
      private static const FOR_LIST:Array = [204927,204928,204929,204934];
      
      private static const FIGHT_INDEX_LIST:Vector.<int> = Vector.<int>([1292,1293,1294]);
      
      private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1,3]);
      
      private static const NPC_LIST:Vector.<int> = Vector.<int>([788,800,804]);
      
      private static const DIALOG_LIST:Vector.<int> = Vector.<int>([816,817,820]);
      
      private static const FINISH_NUM:int = 3;
       
      
      private var _npc:Mobile;
      
      private var _par:Parser_1142;
      
      private var _info:DayLimitListInfo;
      
      public function MapProcessor_80330(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
      }
      
      private function onActInit() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               createNpc();
            });
         });
      }
      
      private function onActDispose() : void
      {
         this.clearNpc();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(600,433));
            this._npc.resourceUrl = URLUtil.getNpcSwf(DIALOG_LIST[this._par.infoVec[3] - 1]);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = PetConfig.getPetDefinition(NPC_LIST[this._par.infoVec[3] - 1]).name;
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var leftNum:int = 0;
         var evt:MouseEvent = param1;
         var winNum:int = int([this._par.infoVec[0],this._par.infoVec[1],this._par.infoVec[2]][this._par.infoVec[3] - 1]);
         if(winNum >= FINISH_NUM)
         {
            NpcDialog.show(DIALOG_LIST[this._par.infoVec[3] - 1],PetConfig.getPetDefinition(NPC_LIST[this._par.infoVec[3] - 1]).name,[[0,"     现在就是觉醒时刻!"]],["这就去"],[function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(3,function():void
               {
                  ModuleManager.showAppModule("ThreeKingProcessPanel");
               });
            }]);
         }
         else
         {
            leftNum = (VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]) - this._info.getCount(DAY_LIST[0]);
            NpcDialog.show(DIALOG_LIST[this._par.infoVec[3] - 1],PetConfig.getPetDefinition(NPC_LIST[this._par.infoVec[3] - 1]).name,[[0,"     战胜我 (" + [this._par.infoVec[0],this._par.infoVec[1],this._par.infoVec[2]][this._par.infoVec[3] - 1] + "/" + FINISH_NUM + ") 次就可以获得觉醒，你今天还有" + leftNum.toString() + "次机会哦。"]],["开始挑战","我不觉了"],[function():void
            {
               if(leftNum > 0)
               {
                  FightManager.startFightWithWild(FIGHT_INDEX_LIST[_par.infoVec[3] - 1]);
               }
               else
               {
                  NpcDialog.show(DIALOG_LIST[_par.infoVec[3] - 1],PetConfig.getPetDefinition(NPC_LIST[_par.infoVec[3] - 1]).name,[[0,"     战胜我 (" + [_par.infoVec[0],_par.infoVec[1],_par.infoVec[2]][_par.infoVec[3] - 1] + "/" + FINISH_NUM + ") 次就可以获得觉醒，你今天还有" + leftNum.toString() + "次机会哦。"]],["开始挑战","我不觉了"],[function():void
                  {
                     if(leftNum > 0)
                     {
                        FightManager.startFightWithWild(FIGHT_INDEX_LIST[_par.infoVec[3] - 1]);
                     }
                     else
                     {
                        NpcDialog.show(DIALOG_LIST[_par.infoVec[3] - 1],PetConfig.getPetDefinition(NPC_LIST[_par.infoVec[3] - 1]).name,[[0,"     今天挑战次数已用完，明天再来吧!"]],["知道了"],[]);
                     }
                  }]);
               }
            }]);
         }
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
         super.dispose();
      }
   }
}
