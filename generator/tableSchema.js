'use strict';

const ID = 'VARCHAR(10)';
const EMAIL = 'VARCHAR(254)';
const TEXT = 'VARCHAR(500)';
const NAME = 'VARCHAR(50)';

module.exports  = {
    location: {
        fields: {
            city: `${NAME} NOT NULL`,
            country: `${NAME} NOT NULL`
        }, keys: { primary: ['city', 'country'] }
    },
    organization: {
        fields: {
            org_id: `${ID} NOT NULL UNIQUE`,
            name: `${NAME}`,
            description: `${TEXT}`,
            phone_number: 'VARCHAR(50)',
            address: 'VARCHAR(50)',
            email: `${EMAIL}`,
            city: `${NAME}`,
            country: `${NAME}`
        }, keys: {
            primary: ['org_id'],
            foreign: {
                "city,country": 'location(city, country)',
            }
        }
    },
    school: {
        fields: {
            org_id: `${ID} NOT NULL UNIQUE`
        },
        keys: {
            primary: ['org_id'],
            foreign: {
                org_id: 'organization(org_id)'
            }
        }
    },
    workplace: {
        fields: {
            org_id: `${ID} NOT NULL UNIQUE`
        },
        keys: {
            primary: ['org_id'],
            foreign: {
                org_id: 'organization(org_id)'
            }
        }
    },
    conversation: {
        fields: {
            convo_id: `${ID} NOT NULL UNIQUE`,
            name: `${NAME} NOT NULL`
        }, keys: { primary: ['convo_id'] }
    },
    users: {
        fields: {
            email: `${EMAIL} NOT NULL UNIQUE`,
            first_name: `${NAME}`,
            last_name: `${NAME}`,
            birthday: 'DATE',
            password: 'VARCHAR(30)',
            gender: `${NAME}`,
            city: `${NAME}`,
            country: `${NAME}`,
        },
        keys: {
            primary: ['email'],
            foreign: {
                "city,country": 'location(city, country)',
            }
        },

    },
    follow: {
        fields: {
            follower: `${EMAIL} NOT NULL`,
            followed_by: `${EMAIL} NOT NULL`,
            since: 'DATE NOT NULL'
        }, keys: {
            primary: ['follower', 'followed_by'], foreign: {
                follower: 'users(email)',
                followed_by: 'users(email)'
            }
        }
    },
    partof: {
        fields: {
            email: `${EMAIL} NOT NULL`,
            convo_id: `${ID} NOT NULL`
        }, keys: { primary: ['email', 'convo_id'], foreign: { email: 'users(email)', convo_id: 'conversation(convo_id)' } }
    },
    wall: {
        fields: {
            wall_id: `${ID} NOT NULL UNIQUE`,
            descr: `${TEXT}`,
            permisson: 'VARCHAR(25)',
            email: `${EMAIL} NOT NULL`
        }, keys: { primary: ['wall_id'], foreign: { email: 'users(email)' } }
    },
    post: {
        fields: {
            pid: `${ID} NOT NULL UNIQUE`,
            wall_id: `${ID} NOT NULL`,
            email: `${EMAIL} NOT NULL`,
            date: 'DATE',
            text: `${TEXT}`,
            url: 'VARCHAR(254)'
        }, keys: { primary: ['pid'], foreign: { wall_id: 'wall(wall_id)', email: 'users(email)' } }
    },
    postreaction: {
        fields: {
            pid: `${ID} NOT NULL`,
            email: `${EMAIL} NOT NULL`,
            type: 'VARCHAR(200)'
        }, keys: { primary: ['pid', 'email'], foreign: { pid: 'post(pid)', email: 'users(email)' } }
    },
    comment: {
        fields: {
            cid: `${ID} NOT NULL UNIQUE`,
            pid: `${ID} NOT NULL`,
            email: `${EMAIL} NOT NULL`,
            text: `${TEXT} NOT NULL`,
            time: 'TIMESTAMP NOT NULL'
        }, keys: { primary: ['cid'] }
    },
    commentreaction: {
        fields: {
            cid: `${ID} NOT NULL`,
            email: `${EMAIL} NOT NULL`,
            type: 'VARCHAR(200)'
        }, keys: { primary: ['cid', 'email'], foreign: { cid: 'comment(cid)', email: 'users(email)' } }
    },
    message: {
        fields: {
            msg_id: `${ID} NOT NULL UNIQUE`,
            email: `${EMAIL} NOT NULL`,
            convo_id: `${ID} NOT NULL`,
            time: 'TIMESTAMP',
            content: `${TEXT} NOT NULL`
        },
        keys: {
            primary: ['msg_id'], foreign: {
                email: 'users(email)',
                convo_id: 'conversation(convo_id)'
            }
        }
    },
       workperiod: { 
           fields: {
        email: `${EMAIL} NOT NULL`,
        org_id: `${ID} NOT NULL`,
        from_date: `DATE NOT NULL`,
        to_date: `DATE NOT NULL`,
        job_title: `${NAME}`
    }, 
    keys: { primary: ['email','org_id','from_date', 'to_date'], foreign: {
        email: 'users(email)', org_id: 'organization(org_id)'
    } } },
    studyperiod: { 
        fields: {
        email: `${EMAIL} NOT NULL`,
        org_id: `${ID} NOT NULL`,
        from_date: `DATE NOT NULL`,
        to_date: `DATE NOT NULL`,
        edu_level: `${NAME}`
    },
     keys: { primary: ['email','org_id','from_date', 'to_date'], foreign: {
        email: 'users(email)', org_id: 'organization(org_id)'
    } }  
}
};