package com.taomee.seer2.app.processor.quest.handler.main.quest10
{
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10_172 extends QuestMapHandler
   {
       
      
      private var _stepAnimation1:MovieClip;
      
      private var _stepAnimation2:MovieClip;
      
      private var _stepAnimation3:MovieClip;
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_10_172(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         LobbyScene(SceneManager.active).hideToolbar();
         this.extractAssets();
         this.processSteps1();
      }
      
      private function extractAssets() : void
      {
         this._stepAnimation1 = _processor.getMcFromLib("mc_172_1");
         this._stepAnimation2 = _processor.getMcFromLib("mc_172_2");
         this._stepAnimation3 = _processor.getMcFromLib("mc_172_3");
         this._teleport = AnimateElementManager.getElement(1) as Teleport;
         this._teleport.visible = false;
      }
      
      private function processSteps1() : void
      {
         if(!_quest.isStepCompete(1))
         {
            NpcDialog.show(11,"多罗",[[1,"做梦都能和队长、巴蒂在一起，这是多罗最最幸福的事情了！"]],[" 做个梦都能这么乐……"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[3,"做梦都能遇到你这个笨蛋！这是我巴蒂最最倒霉的事情了！"]],[" 慢着！难道我们都在做梦？"],[function():void
               {
                  ToolBar.hide();
                  _map.front.addChild(_stepAnimation1);
                  MovieClipUtil.playMc(_stepAnimation1,1,_stepAnimation1.totalFrames,function():void
                  {
                     NpcDialog.show(11,"多罗",[[0,"咦？那个“妹纸”是谁？……怎么这么的眼熟内？长大是个美人胚子……"]],["真吃不消你！"],[function():void
                     {
                        NpcDialog.show(10,"巴蒂",[[3,"囧……你能不能聪明点？看那个丝带一看就是洛水的嘛！根据我冰雪聪明的推理！这是洛水……的小时候！"]],["是……应该没错……"],[function():void
                        {
                           ToolBar.hide();
                           DisplayObjectUtil.removeFromParent(_stepAnimation1);
                           _map.content.addChild(_stepAnimation2);
                           MovieClipUtil.playMc(_stepAnimation2,1,_stepAnimation2.totalFrames,function():void
                           {
                              NpcDialog.show(11,"多罗",[[4,"糟糕！那个萝莉“妹纸”被……被当成食物了……"]],["萝莉你个头！快追啊！"],[function():void
                              {
                                 ToolBar.hide();
                                 DisplayObjectUtil.removeFromParent(_stepAnimation2);
                                 _map.content.addChild(_stepAnimation3);
                                 MovieClipUtil.playMc(_stepAnimation3,1,_stepAnimation3.totalFrames,function():void
                                 {
                                    _teleport.visible = true;
                                 },true);
                              }]);
                           },true);
                        }]);
                     }]);
                  },true);
               }]);
            }]);
         }
      }
      
      override public function processMapDispose() : void
      {
         LobbyScene(SceneManager.active).showToolbar();
         super.processMapDispose();
      }
   }
}
