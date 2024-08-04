enum NotificationType
{
  General("General"),
  BroadcastLive("BroadcastLive") ,
  CareBaby("CareBaby") ,
  Admin("Admin");

  const NotificationType(this.text);
  final String text;
}
