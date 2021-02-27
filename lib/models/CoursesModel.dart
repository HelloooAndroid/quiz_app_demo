
class CoursesModel {
   List<CourseSingleModel> courses;

  CoursesModel(this.courses);

  CoursesModel.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = new List<CourseSingleModel>();
      json['courses'].forEach((v) {
        courses.add(new CourseSingleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class CourseSingleModel {
  int course_id;
  String course_name;

  CourseSingleModel(this.course_id, this.course_name);


  CourseSingleModel.fromJson(Map<String, dynamic> json) {
    course_id = json['course_id'];
    course_name = json['course_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.course_id;
    data['course_name'] = this.course_name;
    return data;
  }


}
