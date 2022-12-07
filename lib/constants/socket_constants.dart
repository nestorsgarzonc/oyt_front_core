class SocketConstants {
  //DINER
  static const addToOrder = 'order:add-item';
  static const callWaiter = 'table:call-waiter';
  static const changeTableStatus = 'table:change-status';
  static const deleteItem = 'order:delete-item';
  static const editItem = 'order:edit-item';
  static const joinSocket = 'table:join';
  static const listenOnPay = 'on_payed_account';
  static const listOfOrders = 'list_of_orders';
  static const onNewUserJoined = 'new_user_joined';
  static const orderNow = 'table:order-now';
  static const stopCallWaiter = 'table:stop-calling-waiter';

  //WAITER
  static const addToOrderToUser = 'waiter:add-item-to-table';
  static const customerRequests = 'customer_requests';
  static const joinToRestaurant = 'restaurant:join';
  static const leaveTable = 'waiter:leave-table';
  static const listenTables = 'restaurant:tables';
  static const orderQueue = 'order_queue';
  static const watchATable = 'watch-table';
  static const watchTable = 'waiter:watch-table';
}
