enum Weekdays {
  monday(name: 'Lunes'),
  tuesday(name: 'Martes'),
  wednesday(name: 'Miercoles'),
  thursday(name: 'Jueves'),
  friday(name: 'Viernes'),
  saturday(name: 'Sabado'),
  sunday(name: 'Domingo'),
  holiday(name: 'Festivos');

  const Weekdays({required this.name});

  final String name;
}
