package com.taomee.seer2.app.processor.map.diceThing.box
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.utils.IDataInput;
   
   public class StarBoxThing extends BoxThing
   {
       
      
      public function StarBoxThing(param1:DiceThingInfo)
      {
         super(param1);
      }
      
      override protected function showResult(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,this.showResult);
         var _loc2_:IDataInput = param1.message.getRawData();
         parse1060 = new Parser_1060(_loc2_);
         var _loc3_:int = parse1060.addItemVec[0].count;
         QueueLoader.load(URLUtil.getActivityAnimation("addStar" + _loc3_),LoadType.SWF,this.onComplete);
      }
      
      override protected function onComplete(param1:ContentInfo) : void
      {
         var mc:MovieClip = null;
         var info:ContentInfo = param1;
         mc = (info.content as MovieClip).getChildAt(0) as MovieClip;
         mc.x = ActorManager.getActor().x - 50;
         mc.y = ActorManager.getActor().y - 100;
         LayerManager.topLayer.addChild(mc);
         MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(mc);
            parse1060.showResult(true,null,false);
            getSuccess();
         });
      }
   }
}
