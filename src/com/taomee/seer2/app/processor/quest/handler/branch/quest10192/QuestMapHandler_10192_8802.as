package com.taomee.seer2.app.processor.quest.handler.branch.quest10192
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootGridPanel;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10192_8802 extends QuestMapHandler
   {
      
      private static var _isDialogHeben:Boolean = false;
       
      
      private var _s:MovieClip;
      
      private var _xue:MovieClip;
      
      private var _xueList:Vector.<MovieClip>;
      
      private var _xueIndexList:Vector.<int>;
      
      private var _heben:MovieClip;
      
      private var _zi:MovieClip;
      
      private var _isShoot:Boolean = false;
      
      public function QuestMapHandler_10192_8802(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.startQuest1();
            if(_isDialogHeben)
            {
               this._isShoot = false;
               _processor.showMouseHintAt(370,493);
               ShootController.addEventListener(ShootEvent.PLAY_START,this.onOpen);
               ShootController.addEventListener(ShootEvent.PLAY_END,this.onPlayEnd);
            }
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.nextQuest2();
         }
      }
      
      private function startQuest1() : void
      {
         this._s = _processor.resLib.getMovieClip("sss");
         this._xue = _processor.resLib.getMovieClip("xue");
         this._heben = _processor.resLib.getMovieClip("heben");
         this._xue.mouseChildren = false;
         this._xue.mouseEnabled = false;
         _map.front.addChild(this._xue);
         _map.content.addChild(this._s);
         _map.content.addChild(this._heben);
         this._xueList = Vector.<MovieClip>([]);
         this._xueIndexList = Vector.<int>([0,0,0,0,0]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._xueList.push(this._xue["xue" + _loc1_]);
            _loc1_++;
         }
         this._s.buttonMode = true;
         this._s.addEventListener(MouseEvent.CLICK,this.onS);
      }
      
      private function onS(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this._isShoot)
         {
            this.onHeben(null);
            return;
         }
         NpcDialog.show(192,"S",[[0,"怎么回事？什么也看不见啊？小赛尔你在哪里？"]],["我在这！"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这里被雪花覆盖了，让我用射击工具将这些雪花清除掉！"]],["用头部射击工具的【火焰】射击试试"],[function():void
            {
               _isDialogHeben = true;
               ShootController.removeEventListener(ShootEvent.PLAY_END,onPlayEnd);
               ShootController.removeEventListener(ShootEvent.PLAY_START,onOpen);
               _processor.showMouseHintAt(370,493);
               _isShoot = false;
               ShootController.addEventListener(ShootEvent.PLAY_START,onOpen);
               ShootController.addEventListener(ShootEvent.PLAY_END,onPlayEnd);
            }]);
         }]);
      }
      
      private function onOpen(param1:ShootEvent) : void
      {
         ShootController.removeEventListener(ShootEvent.PLAY_START,this.onOpen);
         _processor.hideMouseClickHint();
      }
      
      private function onPlayEnd(param1:ShootEvent) : void
      {
         var inde:int = 0;
         var i:int = 0;
         var event:ShootEvent = param1;
         var info:ShootInfo = event.info;
         if(info.userID == ActorManager.actorInfo.id && info.id == 3)
         {
            inde = 100;
            i = 0;
            while(i < 5)
            {
               if(this._xueList[i].hitTestPoint(info.endPos.x,info.endPos.y))
               {
                  inde = i;
               }
               i++;
            }
            if(inde != 100)
            {
               MovieClipUtil.playMc(this._xueList[inde],2,this._xueList[inde].totalFrames,function():void
               {
                  var _loc2_:int = 0;
                  DisplayUtil.removeForParent(_xueList[inde]);
                  _xueIndexList[inde] = 1;
                  var _loc1_:int = 1;
                  for each(_loc2_ in _xueIndexList)
                  {
                     if(_loc2_ == 0)
                     {
                        _loc1_ = _loc2_;
                     }
                  }
                  if(_loc1_ == 1)
                  {
                     ShootController.addEventListener(ShootEvent.PLAY_START,onOpen);
                     ShootController.removeEventListener(ShootEvent.PLAY_END,onPlayEnd);
                     complete1();
                  }
               },true);
            }
         }
      }
      
      private function complete1() : void
      {
         ShootGridPanel.instance.hide();
         this._isShoot = true;
      }
      
      private function onHeben(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(192,"S",[[0,"赫本？！它怎么被封住了？"]],["赫本！"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"赫本！！赫本？！快醒醒！"]],["别叫了，没用的"],[function():void
            {
               NpcDialog.show(192,"S",[[0,"没用的，这是宝石阵，千年冰钻打造的，每一块石头的触角都捆缚着精灵的魂魄！"]],["宝石阵？"],[function():void
               {
                  NpcDialog.show(192,"S",[[0,"赫本从石头中诞生，也只有这种坚固的宝石才能困住它，萨伦看来是有备而来！"]],["难怪这里都没人看守，太有自信了吧，萨伦！"],[function():void
                  {
                     NpcDialog.show(192,"S",[[0,"赛尔！嘘！小点声，我好像听见赫本的梦呓了"]],["哪里哪里？"],[function():void
                     {
                        _zi = _processor.resLib.getMovieClip("zi");
                        _map.front.addChild(_zi);
                        MovieClipUtil.playMc(_zi,2,_zi.totalFrames,function():void
                        {
                           DisplayUtil.removeForParent(_zi);
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                           QuestManager.completeStep(10192,1);
                        },true);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         this.nextQuest2();
      }
      
      private function nextQuest2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10192_1"),function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10192_2"),function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"与我们为敌？赫本一定是被他们洗脑了！"]],["怎么会这样？"],[function():void
               {
                  NpcDialog.show(192,"S",[[0,"我知道了！那个古老的咒语是真的！"]],["什么咒语?"],[function():void
                  {
                     NpcDialog.show(192,"S",[[0,"银羽赫本是宇宙中最忠诚的精灵之一，它会认定将它放入宝石阵的人为主人，并且完成主人的所有命令！"]],["我明白了！"],[function():void
                     {
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"所以它通过梦呓告诉我们它要杀我们，其实是萨伦给它下的命令？"]],["对！"],[function():void
                        {
                           NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哇靠！S，你比柯南还厉害！"]],["救它只有一个办法！"],[function():void
                           {
                              NpcDialog.show(192,"S",[[0,"只要我们打破宝石阵！咒语就会失效！我们就能救走赫本！即使和我们对战的敌人也是它！"]],["好！来吧！我早就想打场漂亮的仗了！"],[function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                                 QuestManager.completeStep(10192,2);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            },true,false,2);
         },true,false,1);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         ModuleManager.toggleModule(URLUtil.getAppModule("HeBenActPanel"),"正在打开...");
         this.removeNpc();
      }
      
      private function removeNpc() : void
      {
         DisplayUtil.removeForParent(this._xue);
         DisplayUtil.removeForParent(this._s);
         DisplayUtil.removeForParent(this._heben);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         DisplayUtil.removeForParent(this._zi);
         super.processMapDispose();
         this.removeNpc();
         ShootController.removeEventListener(ShootEvent.PLAY_START,this.onOpen);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onPlayEnd);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
      }
   }
}
