import 'package:bytenews/models/slider_model.dart';

List<SliderModel> getSliders() {

  List<SliderModel> sliders = [];
  SliderModel sliderModel = SliderModel();

  sliderModel.image = "assets/images/business.jpg";
  sliderModel.name = "Bow to the authority of SilentForce";
  sliders.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.image = "assets/images/entertainment.jpg";
  sliderModel.name = "Bow to the authority of SilentForce";
  sliders.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.image = "assets/images/health.jpg";
  sliderModel.name = "Bow to the authority of SilentForce";
  sliders.add(sliderModel);
  sliderModel = SliderModel();

  return sliders;
}