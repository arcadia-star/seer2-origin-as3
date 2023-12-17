package com.taomee.seer2.app.processor.activity.christmas
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.manager.InteractiveRewardManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class ChristmasFourProcessor
   {
       
      
      private var _dialogThisVec:Vector.<String>;
      
      private var _resourceLoader:ResourceLibraryLoader;
      
      private var _mc0:MovieClip;
      
      private var _mc1:MovieClip;
      
      private var _map:MapModel;
      
      public function ChristmasFourProcessor(param1:MapModel)
      {
         this._dialogThisVec = Vector.<String>(["哇！飞天小麋鹿","没礼物有祝福也不错。","哇！飞天小麋鹿！！","嘿！全家都要健健康康呢！","哇！！！！是哪里呢？","我保证不告诉人家！","……真小气！","光什么呢？"]);
         super();
         this._map = param1;
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         Connection.send(CommandSet.RANDOM_EVENT_1140,10,0);
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         _loc2_.readUnsignedInt();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc5_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc3_ == 1 && QuestManager.isFreshQuestComplete())
         {
            this.play();
         }
      }
      
      private function play() : void
      {
         var url:String = String(URLUtil.getActivityAnimation("9/10"));
         this._resourceLoader = new ResourceLibraryLoader(url);
         this._resourceLoader.getLib(function(param1:ResourceLibrary):void
         {
            _mc0 = param1.getMovieClip("mc0");
            _mc1 = param1.getMovieClip("mc1");
            _map.front.addChild(_mc0);
            _mc0.gotoAndPlay(1);
            _mc0.addEventListener(MouseEvent.CLICK,onClick);
            _mc0.addEventListener(Event.ENTER_FRAME,onEnterFrame);
         });
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this._mc0.currentFrame >= 135 && this._mc0.currentFrame <= 254)
         {
            this._mc0.buttonMode = true;
            this._mc0.mouseChildren = true;
            this._mc0.mouseEnabled = true;
         }
         else
         {
            this._mc0.buttonMode = false;
            this._mc0.mouseChildren = false;
            this._mc0.mouseEnabled = false;
         }
         if(this._mc0.currentFrame == this._mc0.totalFrames)
         {
            this._mc0.stop();
            DisplayUtil.removeForParent(this._mc0);
            this._mc0.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc0.stop();
         this._mc0.removeEventListener(MouseEvent.CLICK,this.onClick);
         this._mc0.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         DisplayUtil.removeForParent(this._mc0);
         this._mc1.gotoAndStop(1);
         this._map.front.addChild(this._mc1);
         InteractiveRewardManager.requestReward(55,function(param1:Parser_1060):void
         {
            var par:Parser_1060 = param1;
            par.showResult();
            MovieClipUtil.playMc(_mc1,2,_mc1.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_mc1);
            });
         });
      }
      
      public function dispose() : void
      {
         if(this._resourceLoader)
         {
            this._resourceLoader.cancel();
         }
         DisplayUtil.removeForParent(this._mc0);
         DisplayUtil.removeForParent(this._mc1);
         if(this._mc0)
         {
            this._mc0.removeEventListener(MouseEvent.CLICK,this.onClick);
            this._mc0.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         this._mc0 = null;
         this._mc1 = null;
      }
   }
}
