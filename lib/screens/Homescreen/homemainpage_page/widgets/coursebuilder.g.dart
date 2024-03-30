// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'coursebuilder.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class CourseAdapter extends TypeAdapter<Course> {
//   @override
//   final int typeId = 1;

//   @override
//   Course read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Course(
//       courseName: fields[0] as String,
//       category: fields[1] as String,
//       courseCode: fields[2] as String,
//       courseCredit: fields[3] as String,
//       selectedDocumentId: fields[4] as String,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Course obj) {
//     writer
//       ..writeByte(5)
//       ..writeByte(0)
//       ..write(obj.courseName)
//       ..writeByte(1)
//       ..write(obj.category)
//       ..writeByte(2)
//       ..write(obj.courseCode)
//       ..writeByte(3)
//       ..write(obj.courseCredit)
//       ..writeByte(4)
//       ..write(obj.selectedDocumentId);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is CourseAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
