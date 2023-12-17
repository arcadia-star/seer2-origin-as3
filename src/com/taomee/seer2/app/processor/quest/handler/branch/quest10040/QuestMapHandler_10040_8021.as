package com.taomee.seer2.app.processor.quest.handler.branch.quest10040
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10040_8021 extends QuestMapHandler
   {
       
      
      private var _comeMc:MovieClip;
      
      private var _playMc:MovieClip;
      
      private var _leaveMc:MovieClip;
      
      public function QuestMapHandler_10040_8021(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.isStepCompletable(2))
         {
            this._comeMc = _processor.resLib.getMovieClip("comeMc");
            this._comeMc.gotoAndStop(1);
            this._playMc = _processor.resLib.getMovieClip("playMc");
            this._playMc.gotoAndStop(1);
            this._leaveMc = _processor.resLib.getMovieClip("leaveMc");
            this._leaveMc.gotoAndStop(1);
            _map.front.addChild(this._comeMc);
            MovieClipUtil.playMc(this._comeMc,1,this._comeMc.totalFrames,function():void
            {
               NpcDialog.show(451,"小乔",[[0,"哎呀！糟糕！……伊特……我……我知错了……可是我想带给赛尔快乐！"]],["伊特？这个名字好似很熟悉？伊特！！！"],[function():void
               {
                  _comeMc.stop();
                  DisplayObjectUtil.removeFromParent(_comeMc);
                  _map.front.addChild(_playMc);
                  MovieClipUtil.playMc(_playMc,1,_playMc.totalFrames,function():void
                  {
                     NpcDialog.show(NpcUtil.getSeerNpcId(),"赛尔",[[2,"都……都是因为我！拜托你放了它……"]],["（这家伙的背影怎么好像哪里见过）"],[function():void
                     {
                        NpcDialog.show(453,"光伊特背影",[[0,"哎哟！有情有义的家伙嘛！那这样！等你先把张贴的工作榜都做完再来找我求情！"]],["（是右边这块吗？）"],[function():void
                        {
                           DisplayObjectUtil.removeFromParent(_playMc);
                           _map.front.addChild(_leaveMc);
                           MovieClipUtil.playMc(_leaveMc,1,_leaveMc.totalFrames,function():void
                           {
                              DisplayObjectUtil.removeFromParent(_leaveMc);
                              QuestManager.completeStep(_quest.id,2);
                           },true);
                        }]);
                     }]);
                  },true);
               }]);
            },true);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
      }
   }
}
