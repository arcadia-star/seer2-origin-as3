package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.Module;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class SquirrelAppearsAct
   {
      
      private static var _instance:SquirrelAppearsAct;
       
      
      private var squirrelHouse:Mobile;
      
      private var squirrelEat:Mobile;
      
      private var timeType:int = 202112;
      
      private var startTime:uint = 0;
      
      private var completeCount:int = 0;
      
      private var needTimes:Array;
      
      private var swapid:int;
      
      private var putCount:int;
      
      private var countDown:TextField;
      
      private var needTime:int;
      
      private var passTime:int;
      
      private var module:Module;
      
      private var sp:Sprite;
      
      public function SquirrelAppearsAct()
      {
         this.needTimes = [0,300,600];
         super();
      }
      
      public static function getInstance() : SquirrelAppearsAct
      {
         if(!_instance)
         {
            _instance = new SquirrelAppearsAct();
         }
         return _instance;
      }
      
      public function dispose() : void
      {
         Tick.instance.removeRender(this.updateTime);
         ModuleManager.removeEventListener("WordshipPhenixPanel",ModuleEvent.SHOW,this.showComplete);
         if(this.module)
         {
            this.module.removeEventListener("PutFriutComplete",this.onPutComplete);
         }
         if(this.squirrelEat)
         {
            this.squirrelEat.removeEventListener(MouseEvent.CLICK,this.showDia);
            MobileManager.removeMobile(this.squirrelEat,MobileType.NPC);
         }
         if(this.squirrelHouse)
         {
            TooltipManager.remove(this.squirrelHouse);
            this.squirrelHouse.removeEventListener(MouseEvent.CLICK,this.showActPanel);
            this.squirrelHouse.removeEventListener(MouseEvent.CLICK,this.showDia);
            this.squirrelHouse.removeEventListener(MouseEvent.CLICK,this.clickHouse);
            MobileManager.removeMobile(this.squirrelHouse,MobileType.NPC);
         }
      }
      
      public function setup() : void
      {
         if(SceneManager.active.mapID != ActorManager.actorInfo.id)
         {
            return;
         }
         DayLimitManager.getDoCount(558,function(param1:int):void
         {
            var count:int = param1;
            putCount = count;
            DayLimitManager.getDoCount(559,function(param1:int):void
            {
               completeCount = param1;
               checkState();
            });
         });
      }
      
      private function checkState() : void
      {
         if(!this.squirrelHouse || !this.squirrelHouse.parent)
         {
            this.createSquirrelHouse();
         }
         if(this.completeCount >= 3)
         {
            this.squirrelHouse.addEventListener(MouseEvent.CLICK,this.clickHouse);
            return;
         }
         if(this.putCount > this.completeCount)
         {
            ActiveCountManager.requestActiveCount(this.timeType,this.getStartTime);
         }
         else
         {
            this.squirrelHouse.addEventListener(MouseEvent.CLICK,this.showActPanel);
         }
      }
      
      private function clickHouse(param1:MouseEvent) : void
      {
         AlertManager.showAlert("今天三次喂松鼠的机会已经用完了哟，明天再来吧！");
      }
      
      private function getStartTime(param1:uint, param2:uint) : void
      {
         this.startTime = param2;
         if(!this.countDown)
         {
            this.sp = new Sprite();
            this.countDown = new TextField();
            this.countDown.x = this.countDown.y = 5;
            this.countDown.mouseEnabled = false;
            this.countDown.wordWrap = true;
            this.countDown.textColor = 16777215;
            this.countDown.type = TextFieldType.DYNAMIC;
            this.sp.addChild(this.countDown);
            this.sp.mouseEnabled = false;
            this.sp.graphics.lineStyle(2,3342336);
            this.sp.graphics.beginFill(9335123,0.8);
            this.sp.graphics.drawRoundRect(0,0,110,60,5,5);
         }
         var _loc3_:Date = new Date(this.startTime * 1000);
         var _loc4_:Date = new Date(TimeManager.getServerTime() * 1000);
         this.passTime = TimeManager.getServerTime() - this.startTime;
         if(_loc4_.date != _loc3_.date)
         {
            this.passTime = 0;
            this.startTime = 0;
         }
         this.needTime = this.needTimes[this.completeCount];
         if(this.putCount == 1 && this.completeCount == 0)
         {
            this.passTime = 0;
         }
         if(this.passTime >= this.needTime)
         {
            this.showSquirreEat();
         }
         else
         {
            this.squirrelHouse.removeEventListener(MouseEvent.CLICK,this.showActPanel);
            TooltipManager.addArtTips(this.squirrelHouse,this.sp);
            Tick.instance.addRender(this.updateTime,1000);
         }
      }
      
      private function updateTime(param1:int) : void
      {
         ++this.passTime;
         var _loc2_:int = this.needTime - this.passTime;
         this.countDown.text = "再过" + int(_loc2_ / 60) + "分" + int(_loc2_ % 60) + "秒松鼠就会出现哟!";
         if(this.passTime >= this.needTime)
         {
            Tick.instance.removeRender(this.updateTime);
            this.showSquirreEat();
         }
      }
      
      private function showSquirreEat() : void
      {
         this.squirrelHouse.removeEventListener(MouseEvent.CLICK,this.showActPanel);
         if(this.squirrelHouse)
         {
            TooltipManager.remove(this.squirrelHouse);
         }
         if(!this.squirrelEat)
         {
            this.squirrelEat = new Mobile();
            this.squirrelEat.x = 505;
            this.squirrelEat.y = 330;
            this.squirrelEat.buttonMode = true;
            this.squirrelEat.mouseChildren = false;
         }
         this.squirrelEat.resourceUrl = URLUtil.getActivityMobile("SquirrelEatMobile");
         MobileManager.addMobile(this.squirrelEat,MobileType.NPC);
         this.squirrelEat.addEventListener(MouseEvent.CLICK,this.showDia);
         this.squirrelHouse.addEventListener(MouseEvent.CLICK,this.showDia);
      }
      
      private function showDia(param1:MouseEvent) : void
      {
         this.squirrelHouse.removeEventListener(MouseEvent.CLICK,this.showDia);
         ActiveCountManager.requestActiveCount(202111,this.getDiaResult);
      }
      
      private function getDiaResult(param1:uint, param2:uint) : void
      {
         var type:uint = param1;
         var count:uint = param2;
         if(count == 1)
         {
            NpcDialog.show(532,"松鼠",[[0,"呀呀呀~~果子真好吃，吃得好饱好饱，顺便我再便便一下。嘻嘻~~"]],["啊！好臭好臭"],[this.playShit]);
         }
         else if(count == 2)
         {
            NpcDialog.show(532,"松鼠",[[0,"呀呀呀~~果子真好吃，不过我还没有吃饱饱，你再去种一点给我吃吧~送你3个榛果种子~谢谢你了~~"]],["啊~别跑别跑~"],[this.playRun]);
         }
         else if(count == 3)
         {
            NpcDialog.show(532,"松鼠",[[0,"呀呀呀~~果子真好吃，吃得正是兴起，不如我们来战斗一场助助兴吧。Come  on！你最好带上精灵胶囊捕捉我哟！"]],["来吧，谁怕谁","让我准备一下"],[function():void
            {
               FightManager.startFightWithWild(234);
            }]);
         }
      }
      
      private function playRun() : void
      {
         this.swapid = 796;
         MobileManager.removeMobile(this.squirrelEat,MobileType.NPC);
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("SquirrelRun"),function():void
         {
            clearSquirrel();
         },true,false,1,false);
      }
      
      private function playShit() : void
      {
         this.swapid = 795;
         MobileManager.removeMobile(this.squirrelEat,MobileType.NPC);
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("SquirrelShit"),function():void
         {
            clearSquirrel();
         },true,false,1,false);
      }
      
      private function clearSquirrel() : void
      {
         SwapManager.swapItem(this.swapid,1,this.onSwap);
      }
      
      private function onSwap(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         this.setup();
      }
      
      private function createSquirrelHouse() : void
      {
         if(!this.squirrelHouse)
         {
            this.squirrelHouse = new Mobile();
            this.squirrelHouse.x = 520;
            this.squirrelHouse.y = 322;
            this.squirrelHouse.buttonMode = true;
            this.squirrelHouse.mouseChildren = false;
         }
         this.squirrelHouse.resourceUrl = URLUtil.getActivityMobile("SquirrelHouseMobile");
         MobileManager.addMobile(this.squirrelHouse,MobileType.NPC);
      }
      
      private function showActPanel(param1:MouseEvent) : void
      {
         ModuleManager.addEventListener("SquirrelAppearsPanel",ModuleEvent.SHOW,this.showComplete);
         ModuleManager.toggleModule(URLUtil.getAppModule("SquirrelAppearsPanel"));
      }
      
      private function showComplete(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("SquirrelAppearsPanel",ModuleEvent.SHOW,this.showComplete);
         this.module = ModuleManager.getModule("SquirrelAppearsPanel").module;
         this.module.addEventListener("PutFriutComplete",this.onPutComplete);
      }
      
      private function onPutComplete(param1:Event) : void
      {
         this.module.removeEventListener("PutFriutComplete",this.onPutComplete);
         MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("PutFriut"),this.setup,false,false,1,false);
      }
   }
}
