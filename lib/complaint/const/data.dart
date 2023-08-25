import 'package:kimgwajang/complaint/model/complaint_model.dart';

// 임시 민원 데이터
final List<ComplaintModel> uncompletedComplaints = [
  ComplaintModel(
    id: '1241dfaf',
    title: '도로 포트홀 문제',
    content: '우리 동네 길에 큰 포트홀이 생겼습니다. 바퀴가 깨질 것 같아서 걱정입니다. 빠르게 조치 부탁드립니다.',
    reply: '',
    imagePath: '',
  ),
  ComplaintModel(
    id: '12dfaf',
    title: '소음 공해 문제',
    content: '매일 밤마다 이웃집에서 큰 소리로 음악을 틀어서 잠을 못 이룹니다. 경고 부탁드립니다.',
    reply: '',
    imagePath: '',
  ),
  ComplaintModel(
    id: '12214f',
    title: '공원 청소 요청',
    content: '우리 동네 공원이 쓰레기로 너무 더러워졌습니다. 청소 부탁드립니다.',
    reply: '',
    imagePath: '',
  ),
  ComplaintModel(
      id: '144ad',
      title: '가로등 수리 요청',
      content: '제 집 앞 가로등이 꺼져서 밤에 너무 어둡습니다. 수리 부탁드립니다.',
      reply: '',
      imagePath: ''),
];

final List<ComplaintModel> completedComplaints = [
  ComplaintModel(
      id: '5fad1dfaf',
      title: '불량 주차 신고',
      content: '주민센터 앞 주차장에 항상 불법 주차를 하는 차량이 있습니다. 처리 부탁드립니다.',
      reply: '신고 접수했습니다. 불법 주차 단속을 강화하겠습니다.',
      imagePath: '',
      evaluation: 4),
  ComplaintModel(
      id: '1rqerf',
      title: '공사장 소음 문제',
      content: '아파트 옆 공사장에서 야간에도 소음이 나서 주민들이 피해를 입고 있습니다.',
      reply: '확인하였습니다. 공사장에 야간 작업 중지를 통지하였습니다.',
      imagePath: '',
      evaluation: 3),
  ComplaintModel(
      id: '1dfaf',
      title: '쓰레기 무단투기',
      content: '골목길에 쓰레기를 무단으로 버리는 사람들이 있습니다. 감시 및 처벌 부탁드립니다.',
      reply: '신고 감사합니다. CCTV 설치와 단속을 강화하겠습니다.',
      imagePath: '',
      evaluation: 1),
  ComplaintModel(
      id: 'fasd',
      title: '놀이터 시설 파손',
      content: '아이들이 이용하는 놀이터의 시설이 많이 파손되어 있습니다. 교체나 수리가 필요합니다.',
      reply: '접수하였습니다. 빠른 시일 내에 시설물을 교체하겠습니다.',
      imagePath: ''),
];
