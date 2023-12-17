package com.taomee.seer2.app.processor.activity.decoration
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.manager.OnlyFlagManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.IDataInput;
   
   public class Decoration8011
   {
      
      private static const str1:Array = ["摩羯守护圣衣","水瓶守护圣衣","双鱼守护圣衣","白羊守护圣衣","金牛守护圣衣","双子守护圣衣","巨蟹守护圣衣","狮子守护圣衣","处女守护圣衣","天平守护圣衣","天蝎守护圣衣","射手守护圣衣"];
      
      private static const str2:Array = ["星空咏唱者","星空澄明者","星空遨游者","星空牧羊者","星空鼓舞者","星空变幻者","星空漂泊者","星空坚忍者","星空贞洁者","星空正义者","星空刺杀者","星空追猎者"];
      
      private static const str3:Array = ["摩羯座","水瓶座","双鱼座","白羊座","金牛座","双子座","巨蟹座","狮子座","处女座","天平座","天蝎座","射手座"];
      
      private static const starZ:Array = [746,735,736,737,738,739,740,741,742,743,744,745];
       
      
      private var _npc:Mobile;
      
      private var swapId:int = 735;
      
      private var onlyFlag:int = 548;
      
      public function Decoration8011()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._npc = MobileManager.getMobile(48,MobileType.NPC);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
      }
      
      private function onDialogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:CustomUnit = null;
         var _loc3_:CustomUnit = null;
         if(param1.content == 48)
         {
            if(ActorManager.actorInfo.birthdayInfo.isOpen)
            {
               if(DialogPanel.functionalityBox.getUnit("VIP生日登记"))
               {
                  DialogPanel.functionalityBox.removeUnit(DialogPanel.functionalityBox.getUnit("VIP生日登记"));
               }
               _loc2_ = new CustomUnit(FunctionalityType.ACTIVE,"星座守护者礼包领取","xxx");
               _loc2_.customHandler = this.onUnitClick2;
               DialogPanel.functionalityBox.addUnit(_loc2_);
            }
            else
            {
               _loc3_ = new CustomUnit(FunctionalityType.ACTIVE,"VIP生日登记","xxx");
               _loc3_.customHandler = this.onUnitClick;
               DialogPanel.functionalityBox.addUnit(_loc3_);
            }
         }
      }
      
      private function onUnitClick() : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("BirthdayPanel"),"正在打开...");
      }
      
      private function onUnitClick2() : void
      {
         var index:int = 0;
         var serverDate:Date = new Date(TimeManager.getServerTime() * 1000);
         var currIndex:uint = serverDate.month + 1;
         index = this.getCurDecoration(ActorManager.actorInfo.birthdayInfo.month,ActorManager.actorInfo.birthdayInfo.day);
         if(index == currIndex)
         {
            if(ActorManager.actorInfo.vipInfo.isVip())
            {
               NpcDialog.show(105,"希尔顿",[[0,"我希尔顿代表VIP乐园对你致以最真心的祝福，并送上【" + str1[index - 1] + "】装备和【" + str2[index - 1] + "】坐骑！"]],["谢谢O(∩_∩)O哈哈~"],[function():void
               {
                  SwapManager.swapItem(starZ[index - 1],1,function(param1:IDataInput):void
                  {
                     var data:IDataInput = param1;
                     new SwapInfo(data);
                     OnlyFlagManager.RequestFlag(function():void
                     {
                        OnlyFlagManager.updataFlag(onlyFlag,1);
                     });
                  });
               }]);
            }
            else
            {
               NpcDialog.show(105,"希尔顿",[[0,"嗯……要加入VIP的一员才能获取这套圣衣。快点成为我们的一员吧！"]],["嗯……我考虑一下！"]);
            }
         }
         else
         {
            NpcDialog.show(105,"希尔顿",[[0,"我看了一眼星象，你是" + str3[index - 1] + ",目前并不是你的守护星座时间。您的守护时间是" + index + "月！"]],["好吧，我再等等。"]);
         }
      }
      
      private function getCurDecorationSwapGift() : int
      {
         var _loc4_:int = 0;
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:int = _loc1_.month + 1;
         var _loc3_:int = _loc1_.date;
         switch(DecorationManager.getCurDecIndex(_loc2_.toString(),_loc3_.toString()))
         {
            case 0:
               _loc4_ = 735;
               break;
            case 1:
               _loc4_ = 736;
               break;
            case 2:
               _loc4_ = 737;
               break;
            case 3:
               _loc4_ = 738;
               break;
            case 4:
               _loc4_ = 739;
               break;
            case 5:
               _loc4_ = 740;
               break;
            case 6:
               _loc4_ = 741;
               break;
            case 7:
               _loc4_ = 742;
               break;
            case 8:
               _loc4_ = 743;
               break;
            case 10:
               _loc4_ = 745;
               break;
            case 9:
               _loc4_ = 744;
               break;
            case 11:
               _loc4_ = 746;
         }
         return _loc4_;
      }
      
      private function getCurDecoration(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         switch(uint(param1))
         {
            case 1:
               _loc3_ = uint(param2) >= 20 ? 2 : 1;
               break;
            case 2:
               _loc3_ = uint(param2) >= 19 ? 3 : 2;
               break;
            case 3:
               _loc3_ = uint(param2) >= 21 ? 4 : 3;
               break;
            case 4:
               _loc3_ = uint(param2) >= 20 ? 5 : 4;
               break;
            case 5:
               _loc3_ = uint(param2) >= 21 ? 6 : 5;
               break;
            case 6:
               _loc3_ = uint(param2) >= 22 ? 7 : 6;
               break;
            case 7:
               _loc3_ = uint(param2) >= 23 ? 8 : 7;
               break;
            case 8:
               _loc3_ = uint(param2) >= 23 ? 9 : 8;
               break;
            case 9:
               _loc3_ = uint(param2) >= 23 ? 10 : 9;
               break;
            case 10:
               _loc3_ = uint(param2) >= 24 ? 11 : 10;
               break;
            case 11:
               _loc3_ = uint(param2) >= 30 ? 12 : 11;
               break;
            case 12:
               _loc3_ = uint(param2) >= 22 ? 1 : 12;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
      }
   }
}
