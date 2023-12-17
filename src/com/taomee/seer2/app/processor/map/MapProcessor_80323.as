package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   
   public class MapProcessor_80323 extends FeiyuyiteMap
   {
      
      private static const NpcIds:Vector.<int> = Vector.<int>([3113]);
      
      private static const FightIds:Vector.<int> = Vector.<int>([1816]);
      
      private static const Positions:Vector.<Point> = Vector.<Point>([new Point(642,272)]);
       
      
      private var timeIndex:Array;
      
      private var index:int;
      
      private var _petBagBtn:SimpleButton;
      
      private var _mobiles:Vector.<Mobile>;
      
      private const FIGHT_ID:Array = [1841,1842];
      
      public function MapProcessor_80323(param1:MapModel)
      {
         this.timeIndex = [2,5,8];
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function init() : void
      {
         this.hideLobbyMenu();
         FightManager.addEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
         this.checkIsInTime3();
         this._mobiles = new Vector.<Mobile>();
         this._mobiles.push(new Mobile());
         super.init();
      }
      
      private function overHandler(param1:FightStartEvent) : void
      {
         this.resultFunc();
      }
      
      private function resultFunc() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
         FightManager.removeEventListener(FightStartEvent.FIGHT_OVER,this.overHandler);
         SceneManager.changeScene(SceneType.LOBBY,70);
         TweenNano.delayedCall(1,function():void
         {
            ModuleManager.showAppModule("StarShadowPanel");
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function checkIsInTime3() : void
      {
         var _loc1_:Array = [13,18,21];
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc3_:int = _loc2_.month;
         var _loc4_:int = _loc2_.date;
         var _loc5_:int = _loc2_.hours;
         var _loc6_:int = _loc2_.minutes;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         while(_loc8_ < 3)
         {
            if(_loc6_ <= 30 && _loc5_ == _loc1_[_loc8_])
            {
               _loc7_ = true;
               this.index = _loc8_;
            }
            _loc8_++;
         }
      }
      
      private function addEvent() : void
      {
         this._mobiles[0].resourceUrl = URLUtil.getNpcSwf(NpcIds[0]);
         this._mobiles[0].buttonMode = true;
         this._mobiles[0].addEventListener(MouseEvent.CLICK,this.toFight);
         this._mobiles[0].setPostion(Positions[0]);
         this._mobiles[0].height = 100;
         MobileManager.addMobile(this._mobiles[0],MobileType.NPC);
         DayLimitListManager.getDaylimitList([1954,1953],function callback(param1:DayLimitListInfo):void
         {
            var _loc2_:uint = param1.getCount(1953);
            var _loc3_:uint = param1.getCount(1954);
            _mobiles[0].visible = BitUtil.getBit(_loc2_,timeIndex[index]) > 0 && BitUtil.getBit(_loc3_,timeIndex[index]) <= 0;
         });
      }
      
      private function _petBagHandler(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._petBagBtn.visible = false;
         NpcDialog.show(400,"小赛尔",[[0,"母船探测到的奇异的引力波讯号就是来自于这里了……好像没什么异样……咦，这是什么？"]],["（拾起星屑）"],[function():void
         {
            SwapManager.swapItem(4580,1,function success(param1:IDataInput):void
            {
               new SwapInfo(param1);
            });
         }]);
      }
      
      override protected function toFight(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var dialog:Array = [[400,"小赛尔",[[0,"母船探测到的奇异的引力波讯号就是来自于这里了……哇！那里好像有只精灵——天呐，那不是观星者吗？"]],["好像又有点儿长得不一样……"]],[3113,"星之首影",[[0,"吾……为……塞纳……留斯……圣徒。不敬者……速速……退避。"]],[" 什么鬼。。哇！！不要一言不合就开打啊！"]]];
         var dialog0:Array = [[400,"小赛尔",[[0,"塞纳留斯圣徒！且留步！！"]],["传说中驾驭星空的精灵为何会出现在这里？"]],[3113,"星之首影",[[0,"吾等……驾驭星空王……执掌大地王……非今次之显者也。"]],["什么意思……听不懂……"]],[400,"小赛尔",[[0,"汝……可终此乱世。汝……将造就王者。"]],["诶？哇！又攻击我了！！"]]];
         var tempArray:Array = ItemManager.getItemQuantityByReferenceId(401284) < 255 ? dialog : dialog0;
         NpcDialog.showDialogs(tempArray,function():void
         {
            FightManager.startFightWithWild(FIGHT_ID[ItemManager.getItemQuantityByReferenceId(401284) < 255 ? 0 : 1]);
         });
      }
   }
}
