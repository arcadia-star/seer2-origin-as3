package com.taomee.seer2.app.activity.processor.PrizeCeremony
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.utils.IDataInput;
   
   public class PrizeGiving
   {
       
      
      public function PrizeGiving()
      {
         super();
         ServerBufferManager.getServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,function(param1:ServerBuffer):void
         {
            var _loc2_:int = param1.readDataAtPostion(2);
            if(_loc2_ == 0)
            {
               initNPC();
            }
            else
            {
               initHasGiving();
            }
         });
      }
      
      public function getNpcId() : uint
      {
         if(PetKingNumber.getItem() == 1)
         {
            return 2;
         }
         if(PetKingNumber.getItem() == 2)
         {
            return 3;
         }
         if(PetKingNumber.getItem() == 3)
         {
            return 11;
         }
         return 0;
      }
      
      public function getFaceId() : uint
      {
         if(PetKingNumber.getItem() == 1)
         {
            return 4;
         }
         if(PetKingNumber.getItem() == 2)
         {
            return 0;
         }
         if(PetKingNumber.getItem() == 3)
         {
            return 1;
         }
         return 0;
      }
      
      public function getNpcName() : String
      {
         if(PetKingNumber.getItem() == 1)
         {
            return "伊娃";
         }
         if(PetKingNumber.getItem() == 2)
         {
            return "上尉";
         }
         if(PetKingNumber.getItem() == 3)
         {
            return "多罗";
         }
         return "";
      }
      
      private function initNPC() : void
      {
         if(Boolean(DateUtil.inInDateScope(5,14,30,15,1)) || Boolean(DateUtil.inInDateScope(6,14,30,15,1)) || Boolean(DateUtil.inInDateScope(0,14,30,15,1)) || Boolean(DateUtil.inInDateScope(1,14,30,15,1)) || Boolean(DateUtil.inInDateScope(2,14,30,15,1)) || Boolean(DateUtil.inInDateScope(3,14,30,15,1)) || Boolean(DateUtil.inInDateScope(4,14,30,15,1)))
         {
            if(ItemManager.getSpecialItem(500508) == null && ItemManager.getSpecialItem(500509) == null && ItemManager.getSpecialItem(500510) == null)
            {
               AlertManager.showAlert("你没有参加过争霸赛，不能领奖哦!");
            }
            else if(ItemManager.getSpecialItem(500508) != null)
            {
               PetKingNumber.getNumber(function():void
               {
                  switch(PetKingNumber.getTeam())
                  {
                     case 1:
                        first();
                        break;
                     case 2:
                        Second();
                        break;
                     case 3:
                        Third();
                  }
               });
            }
            else if(ItemManager.getSpecialItem(500509) != null)
            {
               PetKingNumber.getNumber(function():void
               {
                  switch(PetKingNumber.getTeam())
                  {
                     case 1:
                        first();
                        break;
                     case 2:
                        Second();
                        break;
                     case 3:
                        Third();
                  }
               });
            }
            else if(ItemManager.getSpecialItem(500510) != null)
            {
               PetKingNumber.getNumber(function():void
               {
                  switch(PetKingNumber.getTeam())
                  {
                     case 1:
                        first();
                        break;
                     case 2:
                        Second();
                        break;
                     case 3:
                        Third();
                  }
               });
            }
         }
         else
         {
            AlertManager.showAlert("颁奖礼时间是14:30-15:00哦。");
         }
      }
      
      private function first() : void
      {
         var faceId:uint = 0;
         faceId = this.getFaceId();
         NpcDialog.show(this.getNpcId(),this.getNpcName(),[[faceId,"经过数周的激战，我们的第一届精灵争霸赛落下帷幕了，祝贺你<font color=\'#ffcc00\'>{$name}</font>！你是我们队的荣耀, 请接受属于你的冠军奖励！"]],["我要领奖！","想一下获奖感言再领。。。"],[function():void
         {
            NpcDialog.show(getNpcId(),getNpcName(),[[faceId,"你的冠军奖品是：绝版精灵帕拉丁、1个冠军皇冠、100W经验、7天VIP使用、100块争霸赛奖牌、1W赛尔豆、争霸赛纪念章"]],["谢谢队长 我会更加努力的！"],[function():void
            {
               MovieClipUtil.playFullScreen("res/activity/animation/petPrize/hotFire.swf",function():void
               {
                  MovieClipUtil.playFullScreen("res/activity/animation/petPrize/flayPrize.swf",function():void
                  {
                     MovieClipUtil.playFullScreen("res/activity/animation/petPrize/littleBad.swf",function():void
                     {
                        SwapManager.swapItem(522,1,function(param1:IDataInput):void
                        {
                           StatisticsManager.sendNovice(StatisticsManager.ui_interact_88);
                           var _loc2_:* = new SwapInfo(param1);
                           ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,2,1);
                        });
                     },true,false,2);
                  },true,false,2);
               },true,false,2);
            }]);
         }]);
      }
      
      private function Third() : void
      {
         NpcDialog.show(this.getNpcId(),this.getNpcName(),[[this.getFaceId(),"经过数周的激战，我们的第一届精灵争霸赛落下帷幕了，祝贺你<font color=\'#ffcc00\'>{$name}</font>！你是我们队的荣耀， 请接受属于你的奖励！"]],["我要领奖！","想一下获奖感言再领。。。"],[function():void
         {
            NpcDialog.show(getNpcId(),getNpcName(),[[getFaceId(),"你的奖品是：20W经验、3天VIP使用、20块争霸赛奖牌、争霸赛纪念章"]],["谢谢队长 我会更加努力的！"],[function():void
            {
               MovieClipUtil.playFullScreen("res/activity/animation/petPrize/water.swf",function():void
               {
                  MovieClipUtil.playFullScreen("res/activity/animation/petPrize/littleBad.swf",function():void
                  {
                     SwapManager.swapItem(522,1,function(param1:IDataInput):void
                     {
                        StatisticsManager.sendNovice(StatisticsManager.ui_interact_88);
                        var _loc2_:* = new SwapInfo(param1);
                        ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,2,1);
                     });
                  },true,false,2);
               },true,false,2);
            }]);
         }]);
      }
      
      private function Second() : void
      {
         NpcDialog.show(this.getNpcId(),this.getNpcName(),[[this.getFaceId(),"经过数周的激战，我们的第一届精灵争霸赛落下帷幕了，祝贺你<font color=\'#ffcc00\'>{$name}</font>！你是我们队的荣耀， 请接受属于你的奖励！"]],["我要领奖！","想一下获奖感言再领。。。"],[function():void
         {
            NpcDialog.show(getNpcId(),getNpcName(),[[getFaceId(),"你的奖品是：40W经验、5天VIP使用、30块争霸赛奖牌、争霸赛纪念章"]],["谢谢队长 我会更加努力的！"],[function():void
            {
               MovieClipUtil.playFullScreen("res/activity/animation/petPrize/grass.swf",function():void
               {
                  MovieClipUtil.playFullScreen("res/activity/animation/petPrize/littleBad.swf",function():void
                  {
                     SwapManager.swapItem(522,1,function(param1:IDataInput):void
                     {
                        StatisticsManager.sendNovice(StatisticsManager.ui_interact_88);
                        var _loc2_:* = new SwapInfo(param1);
                        ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980,2,1);
                     });
                  },true,false,2);
               },true,false,2);
            }]);
         }]);
      }
      
      private function initHasGiving() : void
      {
         if(ItemManager.getSpecialItem(500508) != null)
         {
            NpcDialog.show(2,"伊娃",[[4,"奖品已经领过啦。记得参加明年的争霸赛，奖品一定更丰富！"]],["哦…我领过啦？队长您记性还真好哇。"],[]);
         }
         else if(ItemManager.getSpecialItem(500509) != null)
         {
            NpcDialog.show(3,"上尉",[[0,"奖品已经领过啦。记得参加明年的争霸赛，奖品一定更丰富！"]],["哦…我领过啦？队长您记性还真好哇。"],[]);
         }
         else if(ItemManager.getSpecialItem(500510) != null)
         {
            NpcDialog.show(11,"多罗",[[1,"奖品已经领过啦。记得参加明年的争霸赛，奖品一定更丰富！"]],["哦…我领过啦？队长您记性还真好哇。"],[]);
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
