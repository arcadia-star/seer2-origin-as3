package com.taomee.seer2.app.processor.activity.deliciousFood
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferData;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class DeliciousFoodOne
   {
       
      
      private var _map:MapModel;
      
      private var _npc:MovieClip;
      
      private var _serbufList:Vector.<int>;
      
      public function DeliciousFoodOne(param1:MapModel)
      {
         super();
         this._map = param1;
         this.setup();
      }
      
      private function setup() : void
      {
         if(DeliciousFoodLoad.instance.checkTime)
         {
            ServerBufferManager.getServerBuffer(DeliciousFoodOnePickup.getServerBuf(),this.onGetServer,false);
         }
         else if(DateUtil.isInTime(new Date(2013,10,8),new Date(2013,10,10,14,30)))
         {
            if(this.isBeforeHourScope(14,31))
            {
               Tick.instance.addRender(this.valiateStart,2000);
            }
         }
      }
      
      private function isBeforeHourScope(param1:uint, param2:uint = 0) : Boolean
      {
         var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc4_:Date = new Date(_loc3_.fullYear,_loc3_.month,_loc3_.date,param1,param2);
         if(_loc3_ < _loc4_)
         {
            return true;
         }
         return false;
      }
      
      private function valiateStart(param1:int) : void
      {
         if(DeliciousFoodLoad.instance.checkTime)
         {
            ServerBufferManager.getServerBuffer(DeliciousFoodOnePickup.getServerBuf(),this.onGetServer,false);
            Tick.instance.removeRender(this.valiateStart);
         }
      }
      
      private function onGetServer(param1:ServerBuffer) : void
      {
         var _loc5_:Vector.<ServerBufferData> = null;
         var _loc6_:int = 0;
         if(!DeliciousFoodLoad.instance.checkTime)
         {
            return;
         }
         var _loc2_:int = param1.readDataAtPostion(40);
         var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc2_ != 1)
         {
            _loc5_ = new Vector.<ServerBufferData>();
            _loc6_ = 0;
            while(_loc6_ < 38)
            {
               _loc5_.push(new ServerBufferData(_loc6_,0));
               _loc6_++;
            }
            _loc5_.push(new ServerBufferData(40,1));
            ServerBufferManager.updateServerBufferGroup(DeliciousFoodOnePickup.getServerBuf(),_loc5_);
            ServerBufferManager.getServerBuffer(DeliciousFoodOnePickup.getServerBuf(),this.onGetServer,false);
            return;
         }
         this._serbufList = Vector.<int>([]);
         var _loc4_:int = 0;
         while(_loc4_ < 6)
         {
            this._serbufList.push(param1.readDataAtPostion(_loc4_));
            _loc4_++;
         }
         if(param1.readDataAtPostion(6) == 1)
         {
            return;
         }
         this.initNpc();
      }
      
      private function initNpc() : void
      {
         DeliciousFoodLoad.instance.playLoad(function():void
         {
            _npc = DeliciousFoodLoad.instance.getMC("npcOne");
            _map.content.addChild(_npc);
            _npc.x = 434;
            _npc.y = 189;
            _npc.buttonMode = true;
            _npc.addEventListener(MouseEvent.CLICK,onNpc);
         });
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = true;
         for each(_loc3_ in this._serbufList)
         {
            if(_loc3_ != 1)
            {
               _loc2_ = false;
            }
         }
         if(this._serbufList[0] != 1)
         {
            this.dialog1();
         }
         else if(_loc2_ == false)
         {
            this.dialog2();
         }
         else if(_loc2_)
         {
            this.dialog3();
         }
      }
      
      private function dialog1() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[3,"哇哈哈！神猪，神猪！你果然又出现在阿卡迪亚星了！"]],["……"],[function():void
         {
            NpcDialog.show(485,"美食神猪",[[3,"哎呀！铁皮，你来的正巧，我又有事需要你帮助了！"]],["谁是铁皮啊，我都说了我是英勇智慧的赛尔！"],[function():void
            {
               NpcDialog.show(485,"美食神猪",[[3,"好好好，英勇智慧的赛尔，你愿意再帮助我一次吗？  "]],["哦，你说吧，我尽力而为咯"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("deliciousFood/deliciousFoodDialog"),function():void
                  {
                     NpcDialog.show(485,"美食神猪",[[3,"事情经过就是这样！我现在还要修理飞船，找回美食的任务就交给你了！！"]],["嗯嗯，没问题，你知道那些食物掉落的大致地点吗？"],[function():void
                     {
                        NpcDialog.show(485,"美食神猪",[[3,"非常巧合，根据雷达显示，那些食物又再次分散在了五大主城的附近！"]],["好咧，看我的吧！"],[function():void
                        {
                           ServerBufferManager.updateServerBuffer(DeliciousFoodOnePickup.getServerBuf(),0,1);
                           _serbufList[0] = 1;
                           ModuleManager.toggleModule(URLUtil.getAppModule("DeliciousFoodPanel"),"美食神猪");
                        }]);
                     }]);
                  });
               }]);
            }]);
         }]);
      }
      
      private function dialog2() : void
      {
         NpcDialog.show(485,"美食神猪",[[3,"还没找齐5份美食，找齐了再来找我把！"]],["我这就去"]);
      }
      
      private function dialog3() : void
      {
         NpcDialog.show(485,"美食神猪",[[3,"这么快就把所有的食物找到，看来你的智商不低！"]],["额……你这是夸我还是损我！"],[function():void
         {
            NpcDialog.show(485,"美食神猪",[[3,"铁皮，我对你很有兴趣，你有胆量接受我发出的挑战吗？"]],["切！谁怕谁啊，你不就是一头披着披风的猪嘛！"],[function():void
            {
               NpcDialog.show(485,"美食神猪",[[3,"如果你能在14:30之前战胜我5次！我就和你结拜做兄弟"]],["哇！和猪做兄弟真刺激，我接受！"],[function():void
               {
                  NpcDialog.show(485,"美食神猪",[[3,"哈哈哈！我会在阿卡迪亚星四处狂奔！来找我吧。"]],["哼哼！你跑不掉的！"],[function():void
                  {
                     ServerBufferManager.updateServerBuffer(DeliciousFoodOnePickup.getServerBuf(),6,1);
                     DisplayUtil.removeForParent(_npc);
                     DeliciousFoodTwo.startDeliciousFood();
                     ModuleManager.toggleModule(URLUtil.getAppModule("DeliciousFoodPanel"),"美食神猪");
                  }]);
               }]);
            }]);
         }]);
      }
      
      public function dispose() : void
      {
         DisplayUtil.removeForParent(this._npc);
         Tick.instance.removeRender(this.valiateStart);
         this._npc = null;
      }
   }
}
