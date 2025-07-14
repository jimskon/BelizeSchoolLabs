
INSERT INTO titles (table_name, title, subtitle, instructions, footer) VALUES

	-- school_info
    
    ('school_info', 'This is the Title',

		'This is the Subtitle',
		'These are the instructions',
		'This is the footer'),


    ('demographics', 'This is the Title',

		'This is the Subtitle',
		'These are the instructions',
		'This is the footer'),  


    ('curriculum', 'This is the Title',

		'This is the Subtitle',
		'These are the instructions',
		'This is the footer'),  


	('future_curriculum', 'This is the Title',

		'This is the Subtitle',
		'These are the instructions',
		'This is the footer'),


	('computerRoom', 'This is the Title',

		'This is the Subtitle',
		'These are the instructions',
		'This is the footer'),

	('future_computerRoom', 'This is the Title',

		'This is the Subtitle',
		'These are the instructions',
		'This is the footer'), 


	('resources', 'This is the Title',

		'This is the Subtitle',
		'These are the instructions',
		'This is the footer')


ON DUPLICATE KEY UPDATE
    title = VALUES(title),
    subtitle = VALUES(subtitle),
    instructions = VALUES(instructions),
    footer = VALUES(footer);