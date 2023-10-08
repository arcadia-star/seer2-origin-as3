package com.taomee.seer2.app.processor.quest.handler.branch.quest10189
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.ActivePet;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.HitTest;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class QuestMapHandler_10189_2 extends QuestMapHandler
   {
       
      
      private var _markMc:MouseClickHintSprite;
      
      private var _myself:Actor;
      
      private var _Smc:MovieClip;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _starMC:MovieClip;
      
      private var _hebenMC:MovieClip;
      
      private var _bloodMC:MovieClip;
      
      private var _pets:Vector.<ActivePet>;
      
      private var _mapPointList:Array;
      
      private var _petPoint:Point;
      
      private var _petCount:int;
      
      private var _hitCount:int;
      
      public function QuestMapHandler_10189_2(param1:QuestProcessor)
      {
         this._mapPointList = [[160,332],[228,443],[722,214]];
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._myself = ActorManager.getActor();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.playFullMovieOne();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.playHeben();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.playLastMovie();
         }
      }
      
      private function playFullMovieOne() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10189_0"),function():void
         {
            _Smc = _processor.resLib.getMovieClip("mc_0");
            _map.content.addChild(_Smc);
            NpcDialog.show(192,"S",[[0,"你是谁？"]],["你是谁？"],[function():void
            {
               NpcDialog.show(585,"赫本",[[0,"我  赫本  宇宙  奥黛丽  坠落  湖水  使命"]],["额？是念诗吗？（到底说什么啊？不懂……）"],[function():void
               {
                  NpcDialog.show(192,"S",[[0,"这应该是传说中精灵的梦呓状态，其实它还在星系中沉睡，只有无比高贵的精灵才有这种特质！"]],["OMG!那它什么时候醒啊？萨伦那帮人肯定会再来的！"],[function():void
                  {
                     NpcDialog.show(192,"S",[[0,"嘘！快看，它离我们越来越近了！"]],["哪里？哪里？"],[function():void
                     {
                        _mc_0 = _processor.resLib.getMovieClip("mc_1");
                        _map.front.addChild(_mc_0);
                        MovieClipUtil.playMc(_mc_0,1,_mc_0.totalFrames,function():void
                        {
                           if(_mc_0)
                           {
                              DisplayUtil.removeForParent(_mc_0);
                           }
                           NpcDialog.show(192,"S",[[0,"快！赛尔！现在不能有任何东西来干扰它！梦呓中的精灵如果被惊吓，可能会有生命的危险的！"]],["需要我做什么吗？"],[function():void
                           {
                              NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"让我做什么都可以的！它就要真身降临了哦！超级期待的！"]],["对了，S，你怎么知道那么多？"],[function():void
                              {
                                 NpcDialog.show(192,"S",[[0,"你以为我在萨伦白混的吗？萨伦那家伙一直想抓宇宙里最强的精灵，很多精灵的事我都知道！"]],["原来如此！"],[function():void
                                 {
                                    NpcDialog.show(192,"S",[[0,"现在别说这些了，快！好好站岗！别让任何东西打搅它！"]],["嗯嗯！"],[function():void
                                    {
                                       _myself.hide();
                                       ActorManager.showRemoteActor = false;
                                       if(_Smc)
                                       {
                                          DisplayUtil.removeForParent(_Smc);
                                       }
                                       _starMC = _processor.resLib.getMovieClip("mc_2");
                                       _map.front.addChild(_starMC);
                                       MovieClipUtil.playMc(_starMC,1,_starMC.totalFrames,function():void
                                       {
                                          loadMovie();
                                       },true);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        });
                     }]);
                  }]);
               }]);
            }]);
         },true,false,2);
      }
      
      private function loadMovie() : void
      {
         this._myself.hide();
         ActorManager.showRemoteActor = false;
         if(this._starMC)
         {
            DisplayUtil.removeForParent(this._starMC);
         }
         this._hebenMC = _processor.resLib.getMovieClip("heben");
         this._bloodMC = _processor.resLib.getMovieClip("xue");
         _map.front.addChild(this._hebenMC);
         _map.front.addChild(this._bloodMC);
         this._bloodMC.gotoAndStop(1);
         this.createPets();
      }
      
      private function createPets() : void
      {
         var _loc2_:ActivePet = null;
         this._pets = new Vector.<ActivePet>();
         var _loc1_:uint = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new ActivePet(new Point(this._mapPointList[_loc1_][0],this._mapPointList[_loc1_][1]),146);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onPetHandler);
            _loc2_.targetPoint = new Point(481,345);
            MobileManager.addMobile(_loc2_,MobileType.MODEL_PET);
            this._pets.push(_loc2_);
            _loc1_++;
         }
         Tick.instance.addRender(this.hasHitOn,100);
      }
      
      private function onPetHandler(param1:MouseEvent) : void
      {
         var _loc2_:ActivePet = param1.currentTarget as ActivePet;
         this._petPoint = new Point(_loc2_.x,_loc2_.y);
         this.loadPetEffect(1);
         MobileManager.removeMobile(_loc2_,MobileType.MODEL_PET);
         var _loc3_:int = this._pets.indexOf(_loc2_);
         if(_loc3_ != -1)
         {
            this._pets.splice(_loc3_,1);
         }
         var _loc4_:int;
         if((_loc4_ = int(this._pets.length)) == 0)
         {
            if(this._petCount >= 5 && this._hitCount <= 10)
            {
               this._petCount = 0;
               this._hitCount = 1;
               QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
               QuestManager.accept(_quest.id);
               return;
            }
            if(this._hitCount <= 10)
            {
               ++this._petCount;
               this.createPets();
            }
            else
            {
               this._hitCount = 1;
            }
         }
      }
      
      private function loadPetEffect(param1:uint) : void
      {
         if(param1 == 1)
         {
            this.onClickDispose();
         }
         else if(param1 == 0)
         {
            this.onHitDispose();
         }
      }
      
      private function onClickDispose() : void
      {
         var mc:MovieClip = null;
         mc = UIManager.getMovieClip("PetDispose_UI");
         mc.x = this._petPoint.x;
         mc.y = this._petPoint.y;
         SceneManager.active.mapModel.content.addChild(mc);
         MovieClipUtil.getChild(mc,1,0,function(param1:DisplayObject):void
         {
            var _loc2_:MovieClip = param1 as MovieClip;
            MovieClipUtil.playMc(_loc2_,1,_loc2_.totalFrames);
         });
      }
      
      private function onHitDispose() : void
      {
         var mc:MovieClip = null;
         mc = UIManager.getMovieClip("PetDispose_UI");
         mc.x = this._petPoint.x;
         mc.y = this._petPoint.y;
         SceneManager.active.mapModel.content.addChild(mc);
         MovieClipUtil.getChild(mc,1,0,function(param1:DisplayObject):void
         {
            var _loc2_:MovieClip = param1 as MovieClip;
            MovieClipUtil.playMc(_loc2_,1,_loc2_.totalFrames);
         });
      }
      
      private function hasHitOn(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Rectangle = null;
         var _loc6_:ActivePet = null;
         var _loc7_:uint = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this._pets.length)
         {
            if((Boolean(_loc6_ = this._pets[_loc5_])) && Boolean(HitTest.complexHitTestObject(_loc6_,this._hebenMC)))
            {
               _loc4_ = HitTest.intersectionRectangle(_loc6_,this._hebenMC);
               ++this._hitCount;
               if(this._hitCount > 10)
               {
                  this._petCount = 0;
                  this._hitCount = 1;
                  this.NpcNiteTalk();
                  Tick.instance.removeRender(this.hasHitOn);
                  _loc7_ = 0;
                  while(_loc7_ < this._pets.length)
                  {
                     MobileManager.removeMobile(this._pets[_loc7_],MobileType.MODEL_PET);
                     _loc7_++;
                  }
                  this._pets.length = 0;
               }
               else
               {
                  this._bloodMC.gotoAndStop(this._hitCount);
                  this._petPoint = new Point(_loc4_.x,_loc4_.y + _loc4_.height);
                  this.loadPetEffect(0);
                  MobileManager.removeMobile(_loc6_,MobileType.MODEL_PET);
                  _loc3_ = this._pets.indexOf(_loc6_);
                  if(_loc3_ != -1)
                  {
                     this._pets.splice(_loc3_,1);
                  }
                  _loc2_ = int(this._pets.length);
                  if(_loc2_ == 0)
                  {
                     if(this._petCount >= 5 && this._hitCount <= 10)
                     {
                        this._petCount = 0;
                        this._hitCount = 1;
                        QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
                        QuestManager.accept(_quest.id);
                        return;
                     }
                     ++this._petCount;
                     this.createPets();
                  }
               }
            }
            _loc5_++;
         }
      }
      
      private function NpcNiteTalk() : void
      {
         LayerManager.resetOperation();
         if(this._hebenMC)
         {
            DisplayUtil.removeForParent(this._hebenMC);
         }
         if(this._bloodMC)
         {
            DisplayUtil.removeForParent(this._bloodMC);
         }
         this._myself.show();
         ActorManager.showRemoteActor = true;
         this._mc_0 = _processor.resLib.getMovieClip("mc_3");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            loadMovie();
         },true);
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         if(this._hebenMC)
         {
            DisplayUtil.removeForParent(this._hebenMC);
         }
         if(this._bloodMC)
         {
            DisplayUtil.removeForParent(this._bloodMC);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this._myself.show();
         ActorManager.showRemoteActor = true;
         this.playHeben();
      }
      
      private function playHeben() : void
      {
         this._Smc = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._Smc);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_4");
         _map.front.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            HebenTalk();
         },true);
      }
      
      private function HebenTalk() : void
      {
         NpcDialog.show(585,"赫本",[[0,"这次的旅程好漫长！我想这里应该就是阿卡迪亚星吧！"]],["没错！"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"你从哪里来的？刚才你打缇娜实在是太厉害了！你刚才还说梦话了哦！"]],["小赛尔，你好啰嗦！"],[function():void
            {
               NpcDialog.show(192,"S",[[0,"你好！我是S，这是小赛尔，谢谢你刚才救了我们。看得出，你是特别高贵的精灵吧？你从哪里来？"]],["不客气！我是赫本。关于我，不如你们自己去看吧——"],[function():void
               {
                  _myself.hide();
                  ActorManager.showRemoteActor = false;
                  if(_mc_0)
                  {
                     DisplayUtil.removeForParent(_mc_0);
                  }
                  if(_Smc)
                  {
                     DisplayUtil.removeForParent(_Smc);
                  }
                  _mc_1 = _processor.resLib.getMovieClip("mc_5");
                  _map.front.addChild(_mc_1);
                  MovieClipUtil.playMc(_mc_1,1,_mc_1.totalFrames,function():void
                  {
                     _markMc = new MouseClickHintSprite();
                     _map.front.addChild(_markMc);
                     _markMc.x = 583;
                     _markMc.y = 284;
                     _mc_1.buttonMode = true;
                     _mc_1.addEventListener(MouseEvent.CLICK,OnPlaySecondFullMovie);
                  },true);
               }]);
            }]);
         }]);
      }
      
      private function OnPlaySecondFullMovie(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         DisplayObjectUtil.removeFromParent(this._markMc);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10189_1"),function():void
         {
            _myself.show();
            ActorManager.showRemoteActor = true;
            _Smc = _processor.resLib.getMovieClip("mc_0");
            _map.content.addChild(_Smc);
            _mc_0 = _processor.resLib.getMovieClip("hebenNpc");
            _map.content.addChild(_mc_0);
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哦哦哦！我懂了！所以你会从S的项链中出来！那项链就是她爸爸给她的！"]],["是的。"],[function():void
            {
               NpcDialog.show(585,"赫本",[[0,"只有亲情才会润泽项链中的宝石将我从星际游历中召唤回来！"]],["S，你倒是说句话啊"],[function():void
               {
                  NpcDialog.show(192,"S",[[0,"我会保护你的，赫本！这信念就如同我要找到爸爸一样！"]],["赫本！和我们一起走吧！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteOneHandler);
                     QuestManager.completeStep(_quest.id,1);
                  }]);
               }]);
            }]);
         },true,false,2);
      }
      
      private function onCompleteOneHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         this.playLastMovie();
      }
      
      private function playLastMovie() : void
      {
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         this._mc_1 = _processor.resLib.getMovieClip("mc_6");
         _map.front.addChild(this._mc_1);
         if(this._Smc == null)
         {
            this._Smc = _processor.resLib.getMovieClip("mc_0");
            _map.content.addChild(this._Smc);
         }
         if(this._mc_0 == null)
         {
            this._mc_0 = _processor.resLib.getMovieClip("hebenNpc");
            _map.content.addChild(this._mc_0);
         }
         MovieClipUtil.playMc(this._mc_1,1,this._mc_1.totalFrames,function():void
         {
            if(_mc_0)
            {
               DisplayUtil.removeForParent(_mc_0);
            }
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"S，赫本呢？啊？刚才是谁？"]],["是那个魔头萨伦！太龌蹉了！"],[function():void
            {
               NpcDialog.show(192,"S",[[0,"别急，让我想想下一步该怎么办?"]],["嗯！"],[function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                  QuestManager.completeStep(_quest.id,2);
               }]);
            }]);
         },true);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         ModuleManager.toggleModule(URLUtil.getAppModule("ShuangshengQuestsPanel"),"正在打开面板...");
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         if(this._Smc)
         {
            DisplayUtil.removeForParent(this._Smc);
         }
         if(this._starMC)
         {
            DisplayUtil.removeForParent(this._starMC);
         }
         if(this._hebenMC)
         {
            DisplayUtil.removeForParent(this._hebenMC);
         }
         if(this._bloodMC)
         {
            DisplayUtil.removeForParent(this._bloodMC);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         if(this._Smc)
         {
            DisplayUtil.removeForParent(this._Smc);
         }
         if(this._starMC)
         {
            DisplayUtil.removeForParent(this._starMC);
         }
         if(this._hebenMC)
         {
            DisplayUtil.removeForParent(this._hebenMC);
         }
         if(this._bloodMC)
         {
            DisplayUtil.removeForParent(this._bloodMC);
         }
      }
   }
}
