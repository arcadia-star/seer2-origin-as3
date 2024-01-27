package {
import flash.display.MovieClip;

[Embed(source="/_assets/assets.swf", symbol="UI_LoadingBar")]
public dynamic class UI_LoadingBar extends MovieClip {


    public var progressBar:MovieClip;

    public var cover:UI_ScreenCover;

    public var progressPet:MovieClip;

    public function UI_LoadingBar() {
        super();
    }
}
}
