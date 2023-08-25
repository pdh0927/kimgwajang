import 'package:kimgwajang/complaint/model/complaint_model.dart';

// 임시 민원 데이터
final List<ComplaintModel> complaints = [
  ComplaintModel(
      title: '도로 포트홀 문제',
      content: '우리 동네 길에 큰 포트홀이 생겼습니다. 바퀴가 깨질 것 같아서 걱정입니다. 빠르게 조치 부탁드립니다.',
      reply: '민원을 접수했습니다. 1주일 내로 수리 예정입니다.'),
  ComplaintModel(
      title: '소음 공해 문제',
      content: '매일 밤마다 이웃집에서 큰 소리로 음악을 틀어서 잠을 못 이룹니다. 경고 부탁드립니다.',
      reply: '민원을 확인하였습니다. 해당 주민과 상담하여 조치하겠습니다.'),
  ComplaintModel(
      title: '공원 청소 요청',
      content: '우리 동네 공원이 쓰레기로 너무 더러워졌습니다. 청소 부탁드립니다.',
      reply: '공원 청소 일정을 조정하여 빠른 시일 내로 청소하도록 하겠습니다.'),
  ComplaintModel(
      title: '가로등 수리 요청',
      content: '제 집 앞 가로등이 꺼져서 밤에 너무 어둡습니다. 수리 부탁드립니다.',
      reply: '민원을 접수하였습니다. 가로등 수리팀에 전달하여 빠른 조치를 취하겠습니다.'),
];
