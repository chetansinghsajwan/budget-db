insert into transactions
    (amount, type, date, status, trashed_at)
values
    (100.00, 'credit', '2023-10-01 10:00:00', 'completed', null),
    (50.00, 'debit', '2023-10-02 11:00:00', 'pending', null),
    (200.00, 'credit', '2023-10-03 12:00:00', 'failed', null),
    (75.50, 'debit', '2023-10-04 13:00:00', 'completed', null),
    (150.75, 'credit', '2023-10-05 14:00:00', 'pending', null);
